/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/illustrations
  $AssetsImagesIllustrationsGen get illustrations =>
      const $AssetsImagesIllustrationsGen();

  /// Directory path: assets/images/logo
  $AssetsImagesLogoGen get logo => const $AssetsImagesLogoGen();
}

class $AssetsImagesIllustrationsGen {
  const $AssetsImagesIllustrationsGen();

  /// File path: assets/images/illustrations/illustration_1.png
  AssetGenImage get illustration1 =>
      const AssetGenImage('assets/images/illustrations/illustration_1.png');

  /// File path: assets/images/illustrations/illustration_2.png
  AssetGenImage get illustration2 =>
      const AssetGenImage('assets/images/illustrations/illustration_2.png');

  /// File path: assets/images/illustrations/illustration_3.png
  AssetGenImage get illustration3 =>
      const AssetGenImage('assets/images/illustrations/illustration_3.png');

  /// File path: assets/images/illustrations/illustration_4.png
  AssetGenImage get illustration4 =>
      const AssetGenImage('assets/images/illustrations/illustration_4.png');

  /// File path: assets/images/illustrations/illustration_5.png
  AssetGenImage get illustration5 =>
      const AssetGenImage('assets/images/illustrations/illustration_5.png');

  /// File path: assets/images/illustrations/illustration_6.png
  AssetGenImage get illustration6 =>
      const AssetGenImage('assets/images/illustrations/illustration_6.png');

  /// File path: assets/images/illustrations/illustration_7.png
  AssetGenImage get illustration7 =>
      const AssetGenImage('assets/images/illustrations/illustration_7.png');

  /// File path: assets/images/illustrations/illustration_8.png
  AssetGenImage get illustration8 =>
      const AssetGenImage('assets/images/illustrations/illustration_8.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        illustration1,
        illustration2,
        illustration3,
        illustration4,
        illustration5,
        illustration6,
        illustration7,
        illustration8
      ];
}

class $AssetsImagesLogoGen {
  const $AssetsImagesLogoGen();

  /// File path: assets/images/logo/facebook_logo.png
  AssetGenImage get facebookLogo =>
      const AssetGenImage('assets/images/logo/facebook_logo.png');

  /// File path: assets/images/logo/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/logo/google_logo.png');

  /// File path: assets/images/logo/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [facebookLogo, googleLogo, logo];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
