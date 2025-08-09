import '../../domain/entities/place.dart';

class PlaceModel extends Place {
  const PlaceModel({
    required super.placeId,
    required super.name,
    super.address,
    required super.latitude,
    required super.longitude,
    super.phoneNumber,
    super.website,
    super.rating,
    super.types,
    super.photoReference,
    super.isOpen,
    super.priceLevel,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'];
    final location = geometry?['location'];
    
    return PlaceModel(
      placeId: json['place_id'] ?? '',
      name: json['name'] ?? '',
      address: json['formatted_address'] ?? json['vicinity'],
      latitude: location?['lat']?.toDouble() ?? 0.0,
      longitude: location?['lng']?.toDouble() ?? 0.0,
      phoneNumber: json['formatted_phone_number'],
      website: json['website'],
      rating: json['rating']?.toDouble(),
      types: json['types']?.cast<String>(),
      photoReference: json['photos']?[0]?['photo_reference'],
      isOpen: json['opening_hours']?['open_now'],
      priceLevel: _parsePriceLevel(json['price_level']),
    );
  }

  factory PlaceModel.fromPlaceDetailsJson(Map<String, dynamic> json) {
    final result = json['result'];
    final geometry = result?['geometry'];
    final location = geometry?['location'];
    
    return PlaceModel(
      placeId: result?['place_id'] ?? '',
      name: result?['name'] ?? '',
      address: result?['formatted_address'],
      latitude: location?['lat']?.toDouble() ?? 0.0,
      longitude: location?['lng']?.toDouble() ?? 0.0,
      phoneNumber: result?['formatted_phone_number'],
      website: result?['website'],
      rating: result?['rating']?.toDouble(),
      types: result?['types']?.cast<String>(),
      photoReference: result?['photos']?[0]?['photo_reference'],
      isOpen: result?['opening_hours']?['open_now'],
      priceLevel: _parsePriceLevel(result?['price_level']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'name': name,
      'formatted_address': address,
      'geometry': {
        'location': {
          'lat': latitude,
          'lng': longitude,
        },
      },
      'formatted_phone_number': phoneNumber,
      'website': website,
      'rating': rating,
      'types': types,
      'photos': photoReference != null ? [{'photo_reference': photoReference}] : null,
      'opening_hours': isOpen != null ? {'open_now': isOpen} : null,
      'price_level': _parsePriceLevelToInt(priceLevel),
    };
  }

  static String? _parsePriceLevel(int? priceLevel) {
    switch (priceLevel) {
      case 0:
        return 'Free';
      case 1:
        return 'Inexpensive';
      case 2:
        return 'Moderate';
      case 3:
        return 'Expensive';
      case 4:
        return 'Very Expensive';
      default:
        return null;
    }
  }

  static int? _parsePriceLevelToInt(String? priceLevel) {
    switch (priceLevel) {
      case 'Free':
        return 0;
      case 'Inexpensive':
        return 1;
      case 'Moderate':
        return 2;
      case 'Expensive':
        return 3;
      case 'Very Expensive':
        return 4;
      default:
        return null;
    }
  }
}
