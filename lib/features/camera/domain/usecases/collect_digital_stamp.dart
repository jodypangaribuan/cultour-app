import '../../../../core/utils/typedef.dart';
import '../entities/detected_landmark.dart';
import '../entities/digital_stamp.dart';
import '../repositories/camera_repository.dart';

class CollectDigitalStamp {
  final CameraRepository repository;

  const CollectDigitalStamp(this.repository);

  ResultFuture<DigitalStamp> call(DetectedLandmark landmark) {
    return repository.collectDigitalStamp(landmark);
  }
}
