import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/di/injection_container.dart' as di;
import '../bloc/camera_bloc.dart';
import '../widgets/camera_controls.dart';
import '../widgets/landmark_detection_overlay.dart';

class CameraPage extends StatefulWidget {
  final VoidCallback? onBackPressed;
  
  const CameraPage({super.key, this.onBackPressed});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;
  List<CameraDescription> _cameras = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    final permissionStatus = await Permission.camera.request();
    if (permissionStatus.isGranted) {
      try {
        _cameras = await availableCameras();
        if (_cameras.isNotEmpty) {
          await _setCameraController();
        }
      } catch (e) {
        // Handle camera initialization error
      }
    }
  }

  Future<void> _setCameraController() async {
    if (_cameras.isEmpty) return;

    final camera = _isRearCameraSelected ? _cameras.first : _cameras.last;
    
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
        
        // Initialize camera in BLoC
        context.read<CameraBloc>().add(InitializeCameraEvent(_cameraController!));
      }
    } catch (e) {
      // Handle camera controller error
    }
  }

  Future<void> _takePicture() async {
    if (!_isCameraInitialized || _cameraController == null) return;

    try {
      // Add haptic feedback
      HapticFeedback.lightImpact();
      
      if (!mounted) return;
      context.read<CameraBloc>().add(const TakePictureEvent());
      
      final image = await _cameraController!.takePicture();
      
      // Trigger landmark detection
      if (mounted) {
        context.read<CameraBloc>().add(DetectLandmarkEvent(image.path));
      }
      
    } catch (e) {
      // Handle picture taking error
    }
  }

  void _switchCamera() {
    setState(() {
      _isRearCameraSelected = !_isRearCameraSelected;
      _isCameraInitialized = false;
    });
    _setCameraController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<CameraBloc>(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: BlocConsumer<CameraBloc, CameraState>(
          listener: (context, state) {
            if (state is CameraError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
            
            if (state is CameraStampCollected) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Prangko digital berhasil dikumpulkan!'),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // Camera Preview
                _buildCameraPreview(),
                
                // Header
                _buildHeader(),
                
                // Landmark Detection Overlay
                if (state is CameraLandmarkDetected)
                  LandmarkDetectionOverlay(
                    landmark: state.landmark,
                    onCollectStamp: () {
                      context.read<CameraBloc>().add(CollectStampEvent(state.landmark));
                    },
                  ),
                
                if (state is CameraDetecting)
                  _buildDetectingOverlay(),
                
                if (state is CameraCollectingStamp)
                  _buildCollectingOverlay(),
                
                // Camera Controls
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: CameraControls(
                    onTakePicture: _takePicture,
                    onSwitchCamera: _switchCamera,
                    onOpenGallery: () {
                      // TODO: Implement gallery functionality
                    },
                    isLoading: state is CameraDetecting || state is CameraCollectingStamp,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _cameraController!.value.previewSize?.height ?? 0,
          height: _cameraController!.value.previewSize?.width ?? 0,
          child: CameraPreview(_cameraController!),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.onBackPressed != null) {
                    widget.onBackPressed!();
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              Text(
                'AI Camera',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetectingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.4),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              'Mendeteksi landmark...',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppDimensions.fontL,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.4),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
              strokeWidth: 3,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              'Mengumpulkan prangko digital...',
              style: TextStyle(
                color: Colors.white,
                fontSize: AppDimensions.fontL,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
