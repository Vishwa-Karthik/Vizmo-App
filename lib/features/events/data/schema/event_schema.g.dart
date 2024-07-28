// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventSchemaAdapter extends TypeAdapter<EventSchema> {
  @override
  final int typeId = 0;

  @override
  EventSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventSchema(
      createdAt: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      status: fields[3] as String?,
      startAt: fields[4] as String?,
      duration: fields[5] as int?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EventSchema obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.createdAt)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.startAt)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
