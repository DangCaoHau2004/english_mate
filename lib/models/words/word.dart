import 'package:english_mate/models/words/definition_part.dart';
import 'package:hive/hive.dart';

part 'word.g.dart';

@HiveType(typeId: 0)
class Word {
  @HiveField(0)
  final int wordId;

  @HiveField(1)
  final int unitId;

  @HiveField(2)
  final String term; // Từ vựng chính

  @HiveField(3)
  final String definitionVi; // Định nghĩa tiếng Việt

  @HiveField(4)
  final String definitionEn; // Định nghĩa tiếng Anh

  @HiveField(5)
  final String partOfSpeech; // Loại từ

  @HiveField(6)
  final String image; // đường dẫn ảnh

  @HiveField(7)
  final String phonetic; // phiên âm

  @HiveField(9)
  final String audioPronunciation; //audio của từ

  @HiveField(10)
  final String example; // ví dụ

  @HiveField(11)
  final String audioExample; // âm thanh của ví dụ

  @HiveField(12)
  final String audioDefinitionEn; // âm thanh của định nghĩa tiếng anh
  @HiveField(13)
  final List<DefinitionPart> fullDefinition; // toàn bộ định nghĩa

  @HiveField(14)
  final DateTime updateAt; // thời gian cập nhật từ

  // Constructor để tạo đối tượng Words dễ dàng hơn
  Word({
    required this.wordId,
    required this.unitId,
    required this.term,
    required this.definitionVi,
    required this.definitionEn,
    required this.partOfSpeech,
    required this.image,
    required this.phonetic,
    required this.audioPronunciation,
    required this.example,
    required this.audioExample,
    required this.audioDefinitionEn,
    required this.fullDefinition,
    required this.updateAt,
  });
}
