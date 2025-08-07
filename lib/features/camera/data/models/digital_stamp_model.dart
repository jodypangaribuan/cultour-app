import '../../../../core/utils/typedef.dart';
import '../../domain/entities/digital_stamp.dart';

class DigitalStampModel extends DigitalStamp {
  const DigitalStampModel({
    required super.id,
    required super.landmarkId,
    required super.landmarkName,
    required super.location,
    required super.imageUrl,
    required super.collectedAt,
    required super.latitude,
    required super.longitude,
  });

  factory DigitalStampModel.fromMap(DataMap map) {
    return DigitalStampModel(
      id: map['id'] as String,
      landmarkId: map['landmarkId'] as String,
      landmarkName: map['landmarkName'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      collectedAt: DateTime.parse(map['collectedAt'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'landmarkId': landmarkId,
      'landmarkName': landmarkName,
      'location': location,
      'imageUrl': imageUrl,
      'collectedAt': collectedAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
