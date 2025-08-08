import 'package:hive/hive.dart';
import 'meaning.dart'; // Import model Meaning vừa tạo

part 'definition_part.g.dart';

@HiveType(typeId: 1)
class DefinitionPart {
  @HiveField(0)
  final String pos;
  @HiveField(1)
  final List<Meaning> meanings;

  DefinitionPart({required this.pos, required this.meanings});
}
