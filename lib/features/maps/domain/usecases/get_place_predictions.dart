import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/place_prediction.dart';
import '../repositories/maps_repository.dart';

class GetPlacePredictions {
  final MapsRepository repository;

  GetPlacePredictions(this.repository);

  Future<Either<Failure, List<PlacePrediction>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }
    return await repository.getPlacePredictions(query);
  }
}
