import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';

class CameraControls extends StatelessWidget {
  final VoidCallback onTakePicture;
  final VoidCallback onSwitchCamera;
  final VoidCallback onOpenGallery;
  final bool isLoading;

  const CameraControls({
    super.key,
    required this.onTakePicture,
    required this.onSwitchCamera,
    required this.onOpenGallery,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gallery Button
          _buildControlButton(
            icon: Icons.photo_library,
            onTap: onOpenGallery,
            size: 48,
          ),
          
          // Capture Button
          _buildCaptureButton(),
          
          // Switch Camera Button
          _buildControlButton(
            icon: Icons.flip_camera_ios,
            onTap: onSwitchCamera,
            size: 48,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required double size,
  }) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildCaptureButton() {
    return GestureDetector(
      onTap: isLoading ? null : onTakePicture,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 4,
          ),
        ),
        child: Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isLoading ? AppColors.textSecondary : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
