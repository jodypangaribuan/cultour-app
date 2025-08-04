class AIDetectionResult {
  final String label;
  final double confidence;

  AIDetectionResult({required this.label, required this.confidence});

  factory AIDetectionResult.fromJson(Map<String, dynamic> json) {
    return AIDetectionResult(
      label: json['label'] ?? 'Tidak dikenali',
      confidence: (json['confidence'] ?? 0).toDouble(),
    );
  }
}
