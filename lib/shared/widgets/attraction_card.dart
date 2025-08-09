import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/utils/responsive_utils.dart';
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
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(context),
              _buildGradientOverlay(context),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
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
        child: Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.xl),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: ResponsiveUtils.getResponsiveHeight(
          context,
          mobile: 80,
          tablet: 90,
          desktop: 100,
        ),
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

  Widget _buildContent(BuildContext context) {
    return Positioned(
      bottom: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
      left: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
      right: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            attraction.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs)),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
              ),
              SizedBox(width: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs)),
              Text(
                attraction.rating.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (attraction.categories.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                    vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.s),
                    ),
                  ),
                  child: Text(
                    attraction.categories.first,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xs),
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
