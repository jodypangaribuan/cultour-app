import '../../domain/entities/place_prediction.dart';

class PlacePredictionModel extends PlacePrediction {
  const PlacePredictionModel({
    required super.placeId,
    required super.description,
    super.mainText,
    super.secondaryText,
    super.types,
  });

  factory PlacePredictionModel.fromJson(Map<String, dynamic> json) {
    final structuredFormatting = json['structured_formatting'];
    
    return PlacePredictionModel(
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
      mainText: structuredFormatting?['main_text'],
      secondaryText: structuredFormatting?['secondary_text'],
      types: json['types']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'description': description,
      'structured_formatting': {
        'main_text': mainText,
        'secondary_text': secondaryText,
      },
      'types': types,
    };
  }
}
