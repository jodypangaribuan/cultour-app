import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/place_prediction.dart';
import '../../domain/entities/route_info.dart';
import '../../domain/repositories/maps_repository.dart';
import '../datasources/maps_remote_datasource.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource remoteDataSource;

  MapsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PlacePrediction>>> getPlacePredictions(
      String query) async {
    try {
      final predictions = await remoteDataSource.getPlacePredictions(query);
      return Right(predictions);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Place>> getPlaceDetails(String placeId) async {
    try {
      final place = await remoteDataSource.getPlaceDetails(placeId);
      return Right(place);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Place>>> getNearbyPlaces({
    required LatLng location,
    required int radius,
    String? type,
  }) async {
    try {
      final places = await remoteDataSource.getNearbyPlaces(
        location: location,
        radius: radius,
        type: type,
      );
      return Right(places);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, RouteInfo>> getDirections({
    required LatLng origin,
    required LatLng destination,
    String? travelMode,
  }) async {
    try {
      final route = await remoteDataSource.getDirections(
        origin: origin,
        destination: destination,
        travelMode: travelMode,
      );
      return Right(route);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Place>>> searchPlaces({
    required String query,
    LatLng? location,
    int? radius,
  }) async {
    try {
      final places = await remoteDataSource.searchPlaces(
        query: query,
        location: location,
        radius: radius,
      );
      return Right(places);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
