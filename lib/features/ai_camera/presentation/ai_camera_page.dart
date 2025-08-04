import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../ai_camera/data/services/ai_camera_service.dart';
import '../../ai_camera/data/models/ai_detection_result.dart';
import '../../ai_camera/data/repositories/ai_camera_repository_impl.dart';
import '../../ai_camera/domain/entities/ai_result.dart';
import '../../ai_camera/domain/repositories/ai_camera_repository.dart';

class AICameraPage extends StatefulWidget {
  const AICameraPage({super.key});

  @override
  State<AICameraPage> createState() => _AICameraPageState();
}

class _AICameraPageState extends State<AICameraPage> with TickerProviderStateMixin {
  File? _image;
  String? _resultLabel;
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  final AICameraRepository repository = AICameraRepositoryImpl();
  final FlutterTts flutterTts = FlutterTts();

  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  AIResult? _result;
  bool _isDetecting = false;

  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _setupTTS();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _loading = true;
        _resultLabel = null;
      });
      await _sendToAPI(File(pickedFile.path));
    }
  }

  Future<void> _sendToAPI(File image) async {
    final result = await AICameraService().detectImage(image);
    setState(() {
      _loading = false;
      _resultLabel = result != null
          ? "${result.label} (confidence: ${(result.confidence * 100).toStringAsFixed(1)}%)"
          : "Gagal mendeteksi.";
    });
  }

  Future<void> _setupTTS() async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speakResult(AIResult result) async {
    final text = "${result.label}. ${result.description}";
    await flutterTts.speak(text);
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final frontCamera = cameras.first;
      _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
      await _cameraController!.initialize();
      setState(() => _isCameraInitialized = true);
    }
  }

  Future<void> _handleDetection() async {
    setState(() => _isDetecting = true);
    _fadeController.reset();
    
    final result = await repository.detectObject();
    setState(() {
      _result = result;
      _isDetecting = false;
    });
    
    if (result != null) {
      _fadeController.forward();
      await _speakResult(result);
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A), // Deep black
              Color(0xFF2D2D2D), // Dark gray
              Color(0xFF1A1A1A), // Back to deep black
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildCustomAppBar(context),
              
              // Camera Section
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFDC143C).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xFFDC143C).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: _buildCameraView(),
                  ),
                ),
              ),
              
              // Control Panel
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Detection Button
                    _buildDetectionButton(),
                    
                    const SizedBox(height: 20),
                    
                    // Alternative Options
                    _buildAlternativeOptions(),
                  ],
                ),
              ),
              
              // Results Section
              Expanded(
                flex: 2,
                child: _buildResultsSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFDC143C),
                  Color(0xFFB71C1C),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFDC143C).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                'AI Smart Camera',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: const Color(0xFFDC143C).withOpacity(0.5),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              Text(
                'Deteksi Budaya Batak',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: const Color(0xFF1A1A1A),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFFDC143C),
                ),
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Menginisialisasi kamera...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        CameraPreview(_cameraController!),
        
        // Detection Overlay
        if (_isDetecting)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFDC143C),
                            Color(0xFFB71C1C),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFDC143C).withOpacity(0.6),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.scanner,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        
        // Camera Frame Overlay
        CustomPaint(
          painter: CameraFramePainter(),
          size: Size.infinite,
        ),
      ],
    );
  }

  Widget _buildDetectionButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: _isDetecting ? null : _handleDetection,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDC143C),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10,
          shadowColor: const Color(0xFFDC143C).withOpacity(0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isDetecting) ...[
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Mendeteksi...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ] else ...[
              const Icon(Icons.camera_alt_rounded),
              const SizedBox(width: 8),
              const Text('Deteksi Objek Budaya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAlternativeOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildOptionButton(
          icon: Icons.photo_library_rounded,
          label: 'Galeri',
          onTap: () => _pickImage(ImageSource.gallery),
        ),
        _buildOptionButton(
          icon: Icons.volume_up_rounded,
          label: 'Suara',
          onTap: _result != null ? () => _speakResult(_result!) : null,
        ),
      ],
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFDC143C).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC143C).withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFDC143C).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: _result != null
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFDC143C),
                              Color(0xFFB71C1C),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.check_circle_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _result!.label,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFDC143C).withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _result!.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: const Color(0xFF424242),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 48,
                  color: const Color(0xFFDC143C).withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Belum ada hasil deteksi',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF424242),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Arahkan kamera ke objek budaya Batak',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}

class CameraFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFDC143C) // Red frame
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final frameSize = size.width * 0.6;
    final rect = Rect.fromCenter(
      center: center,
      width: frameSize,
      height: frameSize,
    );

    // Draw corner frames with shadow
    const cornerLength = 35.0;
    
    // Shadow first
    // Top-left corner shadow
    canvas.drawLine(
      rect.topLeft + const Offset(1, 1),
      rect.topLeft + const Offset(cornerLength + 1, 1),
      shadowPaint,
    );
    canvas.drawLine(
      rect.topLeft + const Offset(1, 1),
      rect.topLeft + const Offset(1, cornerLength + 1),
      shadowPaint,
    );

    // Top-right corner shadow
    canvas.drawLine(
      rect.topRight + const Offset(1, 1),
      rect.topRight + const Offset(-cornerLength + 1, 1),
      shadowPaint,
    );
    canvas.drawLine(
      rect.topRight + const Offset(1, 1),
      rect.topRight + const Offset(1, cornerLength + 1),
      shadowPaint,
    );

    // Bottom-left corner shadow
    canvas.drawLine(
      rect.bottomLeft + const Offset(1, 1),
      rect.bottomLeft + const Offset(cornerLength + 1, 1),
      shadowPaint,
    );
    canvas.drawLine(
      rect.bottomLeft + const Offset(1, 1),
      rect.bottomLeft + const Offset(1, -cornerLength + 1),
      shadowPaint,
    );

    // Bottom-right corner shadow
    canvas.drawLine(
      rect.bottomRight + const Offset(1, 1),
      rect.bottomRight + const Offset(-cornerLength + 1, 1),
      shadowPaint,
    );
    canvas.drawLine(
      rect.bottomRight + const Offset(1, 1),
      rect.bottomRight + const Offset(1, -cornerLength + 1),
      shadowPaint,
    );

    // Main red frame
    // Top-left corner
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(0, cornerLength),
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(-cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(0, cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(0, -cornerLength),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(-cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(0, -cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}