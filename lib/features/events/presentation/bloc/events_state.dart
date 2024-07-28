part of 'events_bloc.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final VizmoEventsModel? vizmoEventModel;

  const EventsLoaded({required this.vizmoEventModel});

  @override
  List<Object?> get props => [vizmoEventModel];
}

class EventsError extends EventsState {
  final String? errorMessage;

  const EventsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
