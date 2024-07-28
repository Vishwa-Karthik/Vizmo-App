import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vizmo_app/core/injection/injection.dart';
import 'package:vizmo_app/features/events/presentation/bloc/events_bloc.dart';
import 'package:vizmo_app/features/events/presentation/pages/event_page_big.dart';
import 'package:vizmo_app/features/events/presentation/pages/event_page_small.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventsBloc>(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints layout) {
          if (layout.maxWidth > 720) {
            return const EventPageBig();
          }
          return const EventPageSmall();
        },
      ),
    );
  }
}
