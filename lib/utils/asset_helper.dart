class AssetHelper {
  AssetHelper._();

  static const String _audioPath = 'audio/words/';
  static const String _imagePath = 'assets/images/words/';

  static String getAudio(String fileName) {
    return '$_audioPath$fileName';
  }

  static String getImage(String fileName) {
    return '$_imagePath$fileName';
  }
}
