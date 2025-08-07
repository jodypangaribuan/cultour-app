import 'package:equatable/equatable.dart';

class DigitalStamp extends Equatable {
  final String id;
  final String landmarkId;
  final String landmarkName;
  final String location;
  final String imageUrl;
  final DateTime collectedAt;
  final double latitude;
  final double longitude;
  
  const DigitalStamp({
    required this.id,
    required this.landmarkId,
    required this.landmarkName,
    required this.location,
    required this.imageUrl,
    required this.collectedAt,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [
        id,
        landmarkId,
        landmarkName,
        location,
        imageUrl,
        collectedAt,
        latitude,
        longitude,
      ];
}
