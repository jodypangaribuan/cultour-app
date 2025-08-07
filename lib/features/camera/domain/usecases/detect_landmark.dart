import '../../../../core/utils/typedef.dart';
import '../entities/detected_landmark.dart';
import '../repositories/camera_repository.dart';

class DetectLandmark {
  final CameraRepository repository;

  const DetectLandmark(this.repository);

  ResultFuture<DetectedLandmark?> call(String imagePath) {
    return repository.detectLandmark(imagePath);
  }
}
