import '../../../../core/utils/typedef.dart';
import '../entities/attraction.dart';

abstract class HomeRepository {
  ResultFuture<List<Attraction>> getFeaturedAttractions();
  ResultFuture<List<Attraction>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  });
  ResultFuture<List<Attraction>> searchAttractions(String query);
}
