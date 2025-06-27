// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormatsAdapter extends TypeAdapter<Formats> {
  @override
  final int typeId = 2;

  @override
  Formats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Formats(
      imageJpeg: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Formats obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageJpeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
