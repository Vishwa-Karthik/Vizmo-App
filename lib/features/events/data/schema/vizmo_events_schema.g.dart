// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vizmo_events_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VizmoEventsSchemaAdapter extends TypeAdapter<VizmoEventsSchema> {
  @override
  final int typeId = 1;

  @override
  VizmoEventsSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VizmoEventsSchema(
      data: (fields[0] as List?)?.cast<EventSchema?>(),
    );
  }

  @override
  void write(BinaryWriter writer, VizmoEventsSchema obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VizmoEventsSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
