part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class InitializeCameraEvent extends CameraEvent {
  final CameraController controller;

  const InitializeCameraEvent(this.controller);

  @override
  List<Object> get props => [controller];
}

class TakePictureEvent extends CameraEvent {
  const TakePictureEvent();
}

class DetectLandmarkEvent extends CameraEvent {
  final String imagePath;

  const DetectLandmarkEvent(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class CollectStampEvent extends CameraEvent {
  final DetectedLandmark landmark;

  const CollectStampEvent(this.landmark);

  @override
  List<Object> get props => [landmark];
}

class ResetCameraEvent extends CameraEvent {
  const ResetCameraEvent();
}
