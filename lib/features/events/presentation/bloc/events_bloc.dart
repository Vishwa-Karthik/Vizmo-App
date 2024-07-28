import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vizmo_app/features/events/data/models/vizmo_event_model.dart';
import 'package:vizmo_app/features/events/domain/repositories/abstract_event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final AbstractEventRepository eventRepository;
  EventsBloc({required this.eventRepository}) : super(EventsInitial()) {
    on<FetchAPIAndDump>(onFetchAPIAndDump);
    on<FetchEventsFromLocal>(onFetchEventsFromLocal);
  }

  FutureOr<void> onFetchAPIAndDump(
      FetchAPIAndDump event, Emitter<EventsState> emit) async {
    try {
      await eventRepository.fetchAllAndDump();
    } catch (e) {
      emit(EventsError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> onFetchEventsFromLocal(
      FetchEventsFromLocal event, Emitter<EventsState> emit) async {
    try {
      emit(EventsLoading());

      final resultOrFailure =
          await eventRepository.fetchEventsPerDay(targetDate: event.dateTime);

      resultOrFailure.fold(
          (l) => emit(EventsError(errorMessage: l.errorMessage.toString())),
          (VizmoEventsModel r) {
        emit(EventsLoaded(vizmoEventModel: r));
      });
    } catch (e) {
      emit(EventsError(errorMessage: e.toString()));
    }
  }
}
