import 'package:camera/camera.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/detected_landmark.dart';
import '../entities/digital_stamp.dart';

abstract class CameraRepository {
  ResultFuture<List<CameraDescription>> getAvailableCameras();
  ResultFuture<DetectedLandmark?> detectLandmark(String imagePath);
  ResultFuture<DigitalStamp> collectDigitalStamp(DetectedLandmark landmark);
  ResultFuture<List<DigitalStamp>> getUserStamps();
}
