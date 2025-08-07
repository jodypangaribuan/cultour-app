import '../../../../core/utils/typedef.dart';
import '../entities/attraction.dart';
import '../repositories/home_repository.dart';

class GetFeaturedAttractions {
  final HomeRepository repository;

  const GetFeaturedAttractions(this.repository);

  ResultFuture<List<Attraction>> call() {
    return repository.getFeaturedAttractions();
  }
}
