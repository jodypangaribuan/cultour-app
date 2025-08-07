import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/attraction.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<List<Attraction>> getFeaturedAttractions() async {
    try {
      final result = await remoteDataSource.getFeaturedAttractions();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<Attraction>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  }) async {
    try {
      final result = await remoteDataSource.getNearbyAttractions(
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<Attraction>> searchAttractions(String query) async {
    try {
      final result = await remoteDataSource.searchAttractions(query);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
