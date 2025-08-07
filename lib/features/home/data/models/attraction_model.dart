import '../../../../core/utils/typedef.dart';
import '../../domain/entities/attraction.dart';

class AttractionModel extends Attraction {
  const AttractionModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
    required super.categories,
    required super.rating,
    super.isFavorite = false,
  });

  factory AttractionModel.fromMap(DataMap map) {
    return AttractionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      categories: List<String>.from(map['categories'] as List),
      rating: (map['rating'] as num).toDouble(),
      isFavorite: map['isFavorite'] as bool? ?? false,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'categories': categories,
      'rating': rating,
      'isFavorite': isFavorite,
    };
  }

  AttractionModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? latitude,
    double? longitude,
    List<String>? categories,
    double? rating,
    bool? isFavorite,
  }) {
    return AttractionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      categories: categories ?? this.categories,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
