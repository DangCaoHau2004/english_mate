import 'package:audioplayers/audioplayers.dart';
import 'package:english_mate/models/words/word.dart';
import 'package:english_mate/utils/asset_helper.dart';
import 'package:english_mate/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:english_mate/generated/fonts.gen.dart';

class WordDetailView extends StatelessWidget {
  final Word word;

  const WordDetailView({
    super.key,
    required this.word,
    AudioPlayer? audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final AudioPlayer audioPlayer = AudioPlayer();
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    void playAudio(String path) {
      audioPlayer.play(AssetSource(AssetHelper.getAudio(path)));
    }

    Widget buildInfoTile(
      BuildContext context, {
      required String title,
      required String content,
      String? audioUrl,
    }) {
      if (content.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodySmall!.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    StringUtils.capitalizeFirstLetter(content),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Chỉ hiển thị nút play nếu có audioUrl và hàm xử lý
            if (audioUrl != null && audioUrl.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.volume_up),
                onPressed: () {
                  playAudio(audioUrl);
                },
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(StringUtils.capitalizeFirstLetter(word.term))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (word.image.isNotEmpty)
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      AssetHelper.getImage(word.image),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      StringUtils.capitalizeFirstLetter(word.term),
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (word.audioPronunciation.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.volume_up),
                      onPressed: () {
                        playAudio(word.audioPronunciation);
                      },
                    ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (word.phonetic.isNotEmpty)
                    Text(
                      word.phonetic,
                      style: textTheme.bodyMedium!.copyWith(
                        fontFamily: FontFamily.libertinusSans,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  if (word.partOfSpeech.isNotEmpty)
                    Chip(
                      label: Text(
                        StringUtils.capitalizeFirstLetter(word.partOfSpeech),
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onTertiary,
                        ),
                      ),
                      backgroundColor: colorScheme.tertiary,
                    ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(),

              buildInfoTile(
                context,
                title: 'Nghĩa Tiếng Việt',
                content: word.definitionVi,
              ),

              buildInfoTile(
                context,
                title: 'Định nghĩa tiếng Anh',
                content: word.definitionEn,
                audioUrl: word.audioDefinitionEn,
              ),

              buildInfoTile(
                context,
                title: 'Ví dụ',
                content: word.example,
                audioUrl: word.audioExample,
              ),

              const SizedBox(height: 32),

              if (word.fullDefinition.isNotEmpty) ...[
                Text(
                  'Toàn bộ định nghĩa',
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                for (final part in word.fullDefinition)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hiển thị loại từ (pos)
                        Text(
                          StringUtils.capitalizeFirstLetter(part.pos),
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Lặp qua từng nghĩa trong phần đó
                        for (final meaning in part.meanings)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              top: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Hiển thị định nghĩa
                                Text(
                                  '• ${StringUtils.capitalizeFirstLetter(meaning.meaning)}',
                                  style: textTheme.bodyMedium,
                                ),
                                // Lặp qua từng ví dụ của nghĩa đó
                                for (final example in meaning.examples)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      top: 2.0,
                                    ),
                                    child: Text(
                                      "- ${StringUtils.capitalizeFirstLetter(example)}",
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
