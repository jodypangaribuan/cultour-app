import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../domain/entities/detected_landmark.dart';

class LandmarkDetectionOverlay extends StatelessWidget {
  final DetectedLandmark landmark;
  final VoidCallback onCollectStamp;

  const LandmarkDetectionOverlay({
    super.key,
    required this.landmark,
    required this.onCollectStamp,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 200,
      left: AppDimensions.paddingM,
      right: AppDimensions.paddingM,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Landmark Name
                  Text(
                    landmark.name,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingS),
                  
                  // Location
                  Text(
                    landmark.location,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingS),
                  
                  // Confidence Score
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.verified,
                        color: AppColors.success,
                        size: AppDimensions.iconS,
                      ),
                      const SizedBox(width: AppDimensions.paddingXS),
                      Text(
                        '${(landmark.confidence * 100).round()}% yakin',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppDimensions.paddingM),
                  
                  // Collect Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onCollectStamp,
                      icon: const Icon(Icons.card_giftcard),
                      label: const Text(
                        'Kumpulkan Prangko Digital',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingM,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        elevation: 8,
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
