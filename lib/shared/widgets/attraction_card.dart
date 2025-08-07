import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../features/home/domain/entities/attraction.dart';

class AttractionCard extends StatelessWidget {
  final Attraction attraction;
  final VoidCallback? onTap;

  const AttractionCard({
    super.key,
    required this.attraction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(),
              _buildGradientOverlay(),
              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: attraction.imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.backgroundLight,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 2,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.backgroundLight,
        child: const Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: AppDimensions.iconXL,
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      bottom: AppDimensions.paddingS,
      left: AppDimensions.paddingS,
      right: AppDimensions.paddingS,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            attraction.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: AppDimensions.fontS,
              ),
              const SizedBox(width: AppDimensions.paddingXS),
              Text(
                attraction.rating.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (attraction.categories.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusS),
                  ),
                  child: Text(
                    attraction.categories.first,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppDimensions.fontXS,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
