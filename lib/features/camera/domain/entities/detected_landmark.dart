import 'package:equatable/equatable.dart';

class DetectedLandmark extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final double confidence;
  final String category;
  final String imageUrl;
  final double latitude;
  final double longitude;
  
  const DetectedLandmark({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.confidence,
    required this.category,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        description,
        confidence,
        category,
        imageUrl,
        latitude,
        longitude,
      ];
}
