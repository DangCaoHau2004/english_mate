// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meaning.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeaningAdapter extends TypeAdapter<Meaning> {
  @override
  final int typeId = 2;

  @override
  Meaning read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meaning(
      meaning: fields[0] as String,
      examples: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Meaning obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.meaning)
      ..writeByte(1)
      ..write(obj.examples);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeaningAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
