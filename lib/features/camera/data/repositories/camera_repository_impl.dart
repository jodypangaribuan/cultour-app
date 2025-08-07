import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/detected_landmark.dart';
import '../../domain/entities/digital_stamp.dart';
import '../../domain/repositories/camera_repository.dart';
import '../datasources/camera_local_datasource.dart';
import '../models/digital_stamp_model.dart';
import '../services/ai_detection_service.dart';

class CameraRepositoryImpl implements CameraRepository {
  final AIDetectionService aiDetectionService;
  final CameraLocalDataSource localDataSource;

  const CameraRepositoryImpl({
    required this.aiDetectionService,
    required this.localDataSource,
  });

  @override
  ResultFuture<List<CameraDescription>> getAvailableCameras() async {
    try {
      final cameras = await availableCameras();
      return Right(cameras);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<DetectedLandmark?> detectLandmark(String imagePath) async {
    try {
      final result = await aiDetectionService.detectLandmark(imagePath);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<DigitalStamp> collectDigitalStamp(DetectedLandmark landmark) async {
    try {
      final stamp = DigitalStampModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        landmarkId: landmark.id,
        landmarkName: landmark.name,
        location: landmark.location,
        imageUrl: landmark.imageUrl,
        collectedAt: DateTime.now(),
        latitude: landmark.latitude,
        longitude: landmark.longitude,
      );

      await localDataSource.saveDigitalStamp(stamp);
      return Right(stamp);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  ResultFuture<List<DigitalStamp>> getUserStamps() async {
    try {
      final stamps = await localDataSource.getUserStamps();
      return Right(stamps);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
