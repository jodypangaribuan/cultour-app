import 'package:equatable/equatable.dart';

class Attraction extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final List<String> categories;
  final double rating;
  final bool isFavorite;
  
  const Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.categories,
    required this.rating,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        latitude,
        longitude,
        categories,
        rating,
        isFavorite,
      ];
}
