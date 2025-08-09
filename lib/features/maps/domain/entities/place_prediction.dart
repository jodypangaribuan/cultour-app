import 'package:equatable/equatable.dart';

class PlacePrediction extends Equatable {
  final String placeId;
  final String description;
  final String? mainText;
  final String? secondaryText;
  final List<String>? types;

  const PlacePrediction({
    required this.placeId,
    required this.description,
    this.mainText,
    this.secondaryText,
    this.types,
  });

  @override
  List<Object?> get props => [
        placeId,
        description,
        mainText,
        secondaryText,
        types,
      ];
}
