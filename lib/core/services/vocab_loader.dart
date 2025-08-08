import 'dart:convert';
import 'package:english_mate/models/words/definition_part.dart';
import 'package:english_mate/models/words/meaning.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'package:english_mate/models/words/word.dart';

class VocabLoader {
  static Future<void> loadIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyLoaded = prefs.getBool('vocab_loaded') ?? false;

    if (alreadyLoaded) return;

    final jsonString = await rootBundle.loadString('assets/data/data.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    final vocabBox = Hive.box<Word>('wordsBox');

    for (var item in jsonData) {
      final List<DefinitionPart> definitionPart = [];
      for (var definition in item["full_definition_vi"]) {
        final List<Meaning> meanings = [];
        for (var meaning in definition["meanings"]) {
          meanings.add(
            Meaning(
              meaning: meaning["meaning"],
              examples: List<String>.from(meaning["examples"]),
            ),
          );
        }
        definitionPart.add(
          DefinitionPart(pos: definition["pos"], meanings: meanings),
        );
      }
      final Word words = Word(
        wordId: item["id"],
        unitId: item["unit"],
        term: item["word"],
        definitionVi: item["meaning_vi"],
        definitionEn: item["definition_en"],
        audioDefinitionEn: item["audio_meaning"],
        partOfSpeech: item["pos"],
        audioPronunciation: item["audio_pronunciation"],
        image: item["image"],
        phonetic: item["phonetic"],
        fullDefinition: definitionPart,
        example: item["example_en"],
        audioExample: item["audio_example"],
        updateAt: DateTime.now(),
      );
      await vocabBox.put(words.wordId, words);
    }

    await prefs.setBool('vocab_loaded', true);
  }
}
