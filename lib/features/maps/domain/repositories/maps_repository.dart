import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../entities/place.dart';
import '../entities/place_prediction.dart';
import '../entities/route_info.dart';

abstract class MapsRepository {
  Future<Either<Failure, List<PlacePrediction>>> getPlacePredictions(String query);
  Future<Either<Failure, Place>> getPlaceDetails(String placeId);
  Future<Either<Failure, List<Place>>> getNearbyPlaces({
    required LatLng location,
    required int radius,
    String? type,
  });
  Future<Either<Failure, RouteInfo>> getDirections({
    required LatLng origin,
    required LatLng destination,
    String? travelMode,
  });
  Future<Either<Failure, List<Place>>> searchPlaces({
    required String query,
    LatLng? location,
    int? radius,
  });
}
