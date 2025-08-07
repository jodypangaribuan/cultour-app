import '../../../../core/utils/typedef.dart';
import '../../domain/entities/detected_landmark.dart';

class DetectedLandmarkModel extends DetectedLandmark {
  const DetectedLandmarkModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.confidence,
    required super.category,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
  });

  factory DetectedLandmarkModel.fromMap(DataMap map) {
    return DetectedLandmarkModel(
      id: map['id'] as String,
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      confidence: (map['confidence'] as num).toDouble(),
      category: map['category'] as String,
      imageUrl: map['imageUrl'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'confidence': confidence,
      'category': category,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
