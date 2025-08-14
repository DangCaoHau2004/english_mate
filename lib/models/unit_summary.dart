class UnitSummary {
  final int unitId;
  final String thumbnailImage;
  final double? progress;
  UnitSummary({
    required this.unitId,
    required this.thumbnailImage,
    this.progress,
  });
}
