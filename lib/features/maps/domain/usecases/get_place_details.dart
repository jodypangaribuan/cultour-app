import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/place.dart';
import '../repositories/maps_repository.dart';

class GetPlaceDetails {
  final MapsRepository repository;

  GetPlaceDetails(this.repository);

  Future<Either<Failure, Place>> call(String placeId) async {
    return await repository.getPlaceDetails(placeId);
  }
}
