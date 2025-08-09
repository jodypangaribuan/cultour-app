import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/place.dart';
import '../repositories/maps_repository.dart';

class GetNearbyPlaces {
  final MapsRepository repository;

  GetNearbyPlaces(this.repository);

  Future<Either<Failure, List<Place>>> call({
    required LatLng location,
    required int radius,
    String? type,
  }) async {
    return await repository.getNearbyPlaces(
      location: location,
      radius: radius,
      type: type,
    );
  }
}
