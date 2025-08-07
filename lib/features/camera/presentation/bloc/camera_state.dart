part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {
  const CameraInitial();
}

class CameraReady extends CameraState {
  final CameraController controller;

  const CameraReady(this.controller);

  @override
  List<Object> get props => [controller];
}

class CameraTakingPicture extends CameraState {
  final CameraController controller;

  const CameraTakingPicture(this.controller);

  @override
  List<Object> get props => [controller];
}

class CameraDetecting extends CameraState {
  final CameraController controller;
  final String imagePath;

  const CameraDetecting(this.controller, this.imagePath);

  @override
  List<Object> get props => [controller, imagePath];
}

class CameraLandmarkDetected extends CameraState {
  final CameraController controller;
  final DetectedLandmark landmark;
  final String imagePath;

  const CameraLandmarkDetected(this.controller, this.landmark, this.imagePath);

  @override
  List<Object> get props => [controller, landmark, imagePath];
}

class CameraNoLandmarkDetected extends CameraState {
  final CameraController controller;

  const CameraNoLandmarkDetected(this.controller);

  @override
  List<Object> get props => [controller];
}

class CameraCollectingStamp extends CameraState {
  final CameraController controller;
  final DetectedLandmark landmark;

  const CameraCollectingStamp(this.controller, this.landmark);

  @override
  List<Object> get props => [controller, landmark];
}

class CameraStampCollected extends CameraState {
  final CameraController controller;
  final DigitalStamp stamp;

  const CameraStampCollected(this.controller, this.stamp);

  @override
  List<Object> get props => [controller, stamp];
}

class CameraError extends CameraState {
  final CameraController? controller;
  final String message;

  const CameraError(this.controller, this.message);

  @override
  List<Object> get props => [message];
}
