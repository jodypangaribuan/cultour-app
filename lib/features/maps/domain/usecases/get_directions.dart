import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/route_info.dart';
import '../repositories/maps_repository.dart';

class GetDirections {
  final MapsRepository repository;

  GetDirections(this.repository);

  Future<Either<Failure, RouteInfo>> call({
    required LatLng origin,
    required LatLng destination,
    String? travelMode,
  }) async {
    return await repository.getDirections(
      origin: origin,
      destination: destination,
      travelMode: travelMode ?? 'driving',
    );
  }
}
