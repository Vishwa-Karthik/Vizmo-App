import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'event_schema.g.dart';

@HiveType(typeId: 0)
class EventSchema extends Equatable {
  @HiveField(0)
  final String? createdAt;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? status;
  @HiveField(4)
  final String? startAt;
  @HiveField(5)
  final int? duration;
  @HiveField(6)
  final String? id;

  const EventSchema({
    this.createdAt,
    this.title,
    this.description,
    this.status,
    this.startAt,
    this.duration,
    this.id,
  });

  @override
  List<Object?> get props =>
      [createdAt, title, description, status, startAt, duration, id];
}
