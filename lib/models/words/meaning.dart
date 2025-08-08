import 'package:hive/hive.dart';

part 'meaning.g.dart';

@HiveType(typeId: 2)
class Meaning {
  @HiveField(0)
  final String meaning;

  @HiveField(1)
  final List<String> examples;

  Meaning({required this.meaning, required this.examples});
}
