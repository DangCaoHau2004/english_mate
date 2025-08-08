// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 0;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      wordId: fields[0] as int,
      unitId: fields[1] as int,
      term: fields[2] as String,
      definitionVi: fields[3] as String,
      definitionEn: fields[4] as String,
      partOfSpeech: fields[5] as String,
      image: fields[6] as String,
      phonetic: fields[7] as String,
      audioPronunciation: fields[9] as String,
      example: fields[10] as String,
      audioExample: fields[11] as String,
      audioDefinitionEn: fields[12] as String,
      fullDefinition: (fields[13] as List).cast<DefinitionPart>(),
      updateAt: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.unitId)
      ..writeByte(2)
      ..write(obj.term)
      ..writeByte(3)
      ..write(obj.definitionVi)
      ..writeByte(4)
      ..write(obj.definitionEn)
      ..writeByte(5)
      ..write(obj.partOfSpeech)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.phonetic)
      ..writeByte(9)
      ..write(obj.audioPronunciation)
      ..writeByte(10)
      ..write(obj.example)
      ..writeByte(11)
      ..write(obj.audioExample)
      ..writeByte(12)
      ..write(obj.audioDefinitionEn)
      ..writeByte(13)
      ..write(obj.fullDefinition)
      ..writeByte(14)
      ..write(obj.updateAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
