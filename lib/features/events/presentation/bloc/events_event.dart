part of 'events_bloc.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAPIAndDump extends EventsEvent {}

class FetchEventsFromLocal extends EventsEvent {
  final String? dateTime;

  const FetchEventsFromLocal({required this.dateTime});

    @override
  List<Object?> get props => [dateTime];
}
