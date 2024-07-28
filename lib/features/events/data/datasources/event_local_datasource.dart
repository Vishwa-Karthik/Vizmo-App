import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:vizmo_app/features/events/data/models/vizmo_event_model.dart';
import 'package:vizmo_app/features/events/data/schema/event_schema.dart';
import 'package:vizmo_app/features/events/data/schema/vizmo_events_schema.dart';

abstract interface class AbstractEventLocalDatasource {
  Future<VizmoEventsModel> fetchEventsPerDay({required String? targetDate});

  Future<void> dumpEvents({required VizmoEventsModel vizoEventModel});

  Future<bool> hasEventsData();
}

class EventLocalDatasourceImpl implements AbstractEventLocalDatasource {
  @override
  Future<void> dumpEvents({required VizmoEventsModel vizoEventModel}) async {
    try {
      // Convert VizmoEventsModel to VizmoEventsSchema
      final vizmoEventsSchema = vizoEventModel.toSchema();

      // Open the Hive box
      final box = await Hive.openBox<VizmoEventsSchema>('vizmoEventsBox');

      // Store data in the box
      await box.put('vizmoEventsKey', vizmoEventsSchema);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<VizmoEventsModel> fetchEventsPerDay(
      {required String? targetDate}) async {
    try {
      final box = await Hive.openBox<VizmoEventsSchema>('vizmoEventsBox');

      final vizmoEventsSchema = box.get('vizmoEventsKey');

      if (vizmoEventsSchema == null) {
        throw Exception('No events found in the database.');
      }

      final targetDateTime = DateTime.parse(targetDate ?? "");

      final filteredEventSchemas = vizmoEventsSchema.data?.where((eventSchema) {
        if (eventSchema?.startAt == null) return false;

        try {
          final eventDateTime = DateTime.parse(eventSchema!.startAt!);

          final eventDateOnly = DateTime(
              eventDateTime.year, eventDateTime.month, eventDateTime.day);
          final targetEventDateOnly = DateTime(
              targetDateTime.year, targetDateTime.month, targetDateTime.day);
          return eventDateOnly == targetEventDateOnly;
        } catch (e) {
          log('Error parsing date: $e');
          return false;
        }
      }).toList();

      final filteredEvents = filteredEventSchemas?.map((eventSchema) {
        return eventSchema?.toModel();
      }).toList();

      final filteredModel = VizmoEventsModel(data: filteredEvents);

      return filteredModel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> hasEventsData() async {
    try {
      final box = await Hive.openBox<VizmoEventsSchema>('vizmoEventsBox');
      final vizmoEventsSchema = box.get('vizmoEventsKey');
      return vizmoEventsSchema != null &&
          vizmoEventsSchema.data != null &&
          vizmoEventsSchema.data!.isNotEmpty;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

extension EventSchemaConversion on EventSchema {
  Event toModel() {
    return Event(
      createdAt: createdAt,
      title: title,
      description: description,
      status: status,
      startAt: startAt,
      duration: duration,
      id: id,
    );
  }
}

extension VizmoEventsModelConversion on VizmoEventsModel {
  VizmoEventsSchema toSchema() {
    return VizmoEventsSchema(
      data: data?.map((event) => event?.toSchema()).toList(),
    );
  }
}

extension EventConversion on Event {
  EventSchema toSchema() {
    return EventSchema(
      createdAt: createdAt,
      title: title,
      description: description,
      status: status,
      startAt: startAt,
      duration: duration,
      id: id,
    );
  }
}
