import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String placeId;
  final String name;
  final String? address;
  final double latitude;
  final double longitude;
  final String? phoneNumber;
  final String? website;
  final double? rating;
  final List<String>? types;
  final String? photoReference;
  final bool? isOpen;
  final String? priceLevel;

  const Place({
    required this.placeId,
    required this.name,
    this.address,
    required this.latitude,
    required this.longitude,
    this.phoneNumber,
    this.website,
    this.rating,
    this.types,
    this.photoReference,
    this.isOpen,
    this.priceLevel,
  });

  @override
  List<Object?> get props => [
        placeId,
        name,
        address,
        latitude,
        longitude,
        phoneNumber,
        website,
        rating,
        types,
        photoReference,
        isOpen,
        priceLevel,
      ];
}
