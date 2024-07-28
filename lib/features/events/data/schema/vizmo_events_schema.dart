import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:vizmo_app/features/events/data/schema/event_schema.dart';

part 'vizmo_events_schema.g.dart';

@HiveType(typeId: 1)
class VizmoEventsSchema extends Equatable {
  @HiveField(0)
  final List<EventSchema?>? data;

  const VizmoEventsSchema({
    this.data,
  });

  @override
  List<Object?> get props => [data];
}
