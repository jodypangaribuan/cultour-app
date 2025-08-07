import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';

import '../../domain/entities/detected_landmark.dart';
import '../../domain/entities/digital_stamp.dart';
import '../../domain/usecases/detect_landmark.dart';
import '../../domain/usecases/collect_digital_stamp.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final DetectLandmark _detectLandmark;
  final CollectDigitalStamp _collectDigitalStamp;

  CameraBloc({
    required DetectLandmark detectLandmark,
    required CollectDigitalStamp collectDigitalStamp,
  })  : _detectLandmark = detectLandmark,
        _collectDigitalStamp = collectDigitalStamp,
        super(const CameraInitial()) {
    on<InitializeCameraEvent>(_onInitializeCamera);
    on<TakePictureEvent>(_onTakePicture);
    on<DetectLandmarkEvent>(_onDetectLandmark);
    on<CollectStampEvent>(_onCollectStamp);
    on<ResetCameraEvent>(_onResetCamera);
  }

  void _onInitializeCamera(
    InitializeCameraEvent event,
    Emitter<CameraState> emit,
  ) {
    emit(CameraReady(event.controller));
  }

  void _onTakePicture(
    TakePictureEvent event,
    Emitter<CameraState> emit,
  ) {
    if (state is CameraReady) {
      final currentState = state as CameraReady;
      emit(CameraTakingPicture(currentState.controller));
    }
  }

  Future<void> _onDetectLandmark(
    DetectLandmarkEvent event,
    Emitter<CameraState> emit,
  ) async {
    if (state is CameraTakingPicture) {
      final currentState = state as CameraTakingPicture;
      emit(CameraDetecting(currentState.controller, event.imagePath));

      final result = await _detectLandmark(event.imagePath);

      result.fold(
        (failure) => emit(CameraError(currentState.controller, failure.message)),
        (landmark) {
          if (landmark != null) {
            emit(CameraLandmarkDetected(currentState.controller, landmark, event.imagePath));
          } else {
            emit(CameraNoLandmarkDetected(currentState.controller));
          }
        },
      );
    }
  }

  Future<void> _onCollectStamp(
    CollectStampEvent event,
    Emitter<CameraState> emit,
  ) async {
    if (state is CameraLandmarkDetected) {
      final currentState = state as CameraLandmarkDetected;
      emit(CameraCollectingStamp(currentState.controller, currentState.landmark));

      final result = await _collectDigitalStamp(event.landmark);

      result.fold(
        (failure) => emit(CameraError(currentState.controller, failure.message)),
        (stamp) => emit(CameraStampCollected(currentState.controller, stamp)),
      );
    }
  }

  void _onResetCamera(
    ResetCameraEvent event,
    Emitter<CameraState> emit,
  ) {
    if (state is! CameraInitial) {
      final controller = _getControllerFromState(state);
      if (controller != null) {
        emit(CameraReady(controller));
      }
    }
  }

  CameraController? _getControllerFromState(CameraState state) {
    if (state is CameraReady) return state.controller;
    if (state is CameraTakingPicture) return state.controller;
    if (state is CameraDetecting) return state.controller;
    if (state is CameraLandmarkDetected) return state.controller;
    if (state is CameraNoLandmarkDetected) return state.controller;
    if (state is CameraCollectingStamp) return state.controller;
    if (state is CameraStampCollected) return state.controller;
    if (state is CameraError) return state.controller;
    return null;
  }
}
