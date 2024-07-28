import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:vizmo_app/core/injection/injection.dart';
import 'package:vizmo_app/features/events/data/schema/vizmo_events_schema.dart';
import 'package:vizmo_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:vizmo_app/features/events/presentation/widgets/event_tile.dart';
import 'package:vizmo_app/features/events/presentation/shared/event_type_utility.dart';
import 'package:vizmo_app/utils/app_colors.dart';
import 'package:vizmo_app/utils/app_constants.dart';
import 'package:vizmo_app/utils/date_time_utilities.dart';

class EventPageSmall extends StatefulWidget {
  const EventPageSmall({super.key});

  @override
  State<EventPageSmall> createState() => _EventPageSmallState();
}

class _EventPageSmallState extends State<EventPageSmall> with EventTypeUtility {
  late CalendarWeekController calendarWeekController;
  late DateTime selectedDateTime;
  late EventsBloc eventsBloc;
  late Box<VizmoEventsSchema> vizmoEventsBox;
  final DateTime exampleDateFromAPI =
      DateTime.parse("2024-06-07T11:46:27.302Z");

  @override
  void initState() {
    calendarWeekController = CalendarWeekController();
    selectedDateTime = exampleDateFromAPI;
    eventsBloc = sl<EventsBloc>();
    invokeAPIandDump();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calendarWeekController.jumpToDate(exampleDateFromAPI);
      invokeEventsPerDay(dateTime: exampleDateFromAPI.toUtc().toString());
    });
    super.initState();
  }

  Future<void> invokeAPIandDump() async {
    eventsBloc.add(FetchAPIAndDump());
  }

  Future<void> invokeEventsPerDay({required String? dateTime}) async {
    eventsBloc.add(FetchEventsFromLocal(dateTime: dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          AppConstants.appBarTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.whiteColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              AppConstants.scheduleTitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const Gap(10),

            // Calendar
            buildCalendarWeek(),

            const Gap(10),

            // Event Day selected
            Text(
              DateFormat(AppConstants.selectedDateTimeFormat)
                  .format(selectedDateTime)
                  .toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall,
            ),

            const Gap(10),

            // Events for selected day
            buildEventList(),
          ],
        ),
      ),
    );
  }

  Widget buildCalendarWeek() {
    return CalendarWeek(
      controller: calendarWeekController,
      backgroundColor: AppColors.whiteColor,
      height: 150,
      showMonth: true,
      minDate: DateTime.now().add(const Duration(days: -730)),
      maxDate: DateTime.now().add(const Duration(days: 365)),
      onDatePressed: (DateTime datetime) {
        setState(() {
          selectedDateTime = datetime;
        });
        invokeEventsPerDay(dateTime: selectedDateTime.toUtc().toString());
      },
      dayOfWeekStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 16,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
      ),
      dateStyle: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(fontSize: AppConstants.fontSize16),
      dateBackgroundColor: Colors.deepPurple.shade50,
      weekendsIndexes: const [DateTime.daysPerWeek],
      pressedDateBackgroundColor: Colors.deepPurple,
      weekendsStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      pressedDateStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
        fontSize: 22,
      ),
      todayBackgroundColor: Colors.deepPurple,
      onDateLongPressed: (DateTime datetime) {},
      onWeekChanged: () {},
      monthViewBuilder: (DateTime time) => Align(
        alignment: FractionalOffset.center,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              DateFormat.yMMMM().format(time),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
            )),
      ),
      decorations: [
        DecorationItem(
          decorationAlignment: FractionalOffset.bottomRight,
          date: DateTime.now(),
          decoration: const Icon(
            Icons.today,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget buildEventList() {
    return Expanded(
      child: BlocBuilder<EventsBloc, EventsState>(
        builder: (context, state) {
          if (state is EventsLoaded) {
            if (state.vizmoEventModel!.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text(AppConstants.noEventsMessage)),
                  SvgPicture.asset(AppConstants.eventSvgFilePath),
                ],
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return EventTile(
                  time: DateTimeUtilities.eventTimeRange(
                    startAt: state.vizmoEventModel?.data![index]?.startAt ??
                        selectedDateTime.toUtc().toString(),
                    durationMinutes:
                        state.vizmoEventModel?.data![index]?.duration ?? 0,
                  ),
                  isConfirmed: checkEventStatus(
                      eventStatus:
                          state.vizmoEventModel?.data![index]?.status ?? ""),
                  isGroupEvent: index % 2 == 0 ? true : false,
                  onTap: () {},
                  title: state.vizmoEventModel?.data![index]?.title ?? "",
                  subtitle:
                      state.vizmoEventModel?.data![index]?.description ?? "",
                );
              },
              itemCount: state.vizmoEventModel?.data?.length,
            );
          } else if (state is EventsLoading) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is EventsInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is EventsError) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppConstants.errorSvgFilePath,
                      height: AppConstants.imageSize250,
                    ),
                    SizedBox(child: Text(state.errorMessage ?? "")),
                    IconButton(
                      onPressed: () {
                        invokeEventsPerDay(
                            dateTime: selectedDateTime.toUtc().toString());
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox(
                child: Text(AppConstants.somethingWentWrongMessage));
          }
        },
      ),
    );
  }
}
