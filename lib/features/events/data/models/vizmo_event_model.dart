import 'package:equatable/equatable.dart';

class VizmoEventsModel extends Equatable {
  final List<Event?>? data;

  const VizmoEventsModel({
    this.data,
  });

  factory VizmoEventsModel.fromJson(Map<String, dynamic> json) {
    return VizmoEventsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => item == null
              ? null
              : Event.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.map((event) => event?.toJson()).toList() ?? [],
      };

  @override
  List<Object?> get props => [data];
}

class Event extends Equatable {
  final String? createdAt;
  final String? title;
  final String? description;
  final String? status;
  final String? startAt;
  final int? duration;
  final String? id;

  const Event({
    this.createdAt,
    this.title,
    this.description,
    this.status,
    this.startAt,
    this.duration,
    this.id,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      createdAt: json['createdAt'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      startAt: json['startAt'] as String?,
      duration: json['duration'] as int?,
      id: json['id'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "title": title,
        "description": description,
        "status": status,
        "startAt": startAt,
        "duration": duration,
        "id": id,
      };

  @override
  List<Object?> get props =>
      [createdAt, title, description, status, startAt, duration, id];
}
