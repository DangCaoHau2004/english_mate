// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition_part.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DefinitionPartAdapter extends TypeAdapter<DefinitionPart> {
  @override
  final int typeId = 1;

  @override
  DefinitionPart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DefinitionPart(
      pos: fields[0] as String,
      meanings: (fields[1] as List).cast<Meaning>(),
    );
  }

  @override
  void write(BinaryWriter writer, DefinitionPart obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pos)
      ..writeByte(1)
      ..write(obj.meanings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DefinitionPartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
