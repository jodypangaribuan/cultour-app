import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/constants/strings.dart';
import '../../core/utils/responsive_utils.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: ResponsiveUtils.getBottomNavHeight(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Home
              _buildRegularNavItem(
                context,
                svgPath: "M224,115.55V208a16,16,0,0,1-16,16H168a16,16,0,0,1-16-16V168a8,8,0,0,0-8-8H112a8,8,0,0,0-8,8v40a16,16,0,0,1-16,16H48a16,16,0,0,1-16-16V115.55a16,16,0,0,1,5.17-11.78l80-75.48.11-.11a16,16,0,0,1,21.53,0,1.14,1.14,0,0,0,.11.11l80,75.48A16,16,0,0,1,224,115.55Z",
                label: AppStrings.home,
                index: 0,
                isActive: currentIndex == 0,
              ),
              // Maps
              _buildRegularNavItem(
                context,
                svgPath: "M128,64a40,40,0,1,0,40,40A40,40,0,0,0,128,64Zm0,64a24,24,0,1,1,24-24A24,24,0,0,1,128,128Zm0-112a88.1,88.1,0,0,0-88,88c0,31.4,14.51,64.68,42,96.25a254.19,254.19,0,0,0,41.45,38.3,8,8,0,0,0,9.18,0A254.19,254.19,0,0,0,174,200.25c27.45-31.57,42-64.85,42-96.25A88.1,88.1,0,0,0,128,16Zm0,206c-16.53-13-72-60.75-72-118a72,72,0,0,1,144,0C200,161.23,144.53,209,128,222Z",
                label: "Peta",
                index: 2,
                isActive: currentIndex == 2,
              ),
              // Camera inline (center)
              _buildCameraButton(context),
              // Language
              _buildRegularNavItem(
                context,
                svgPath: "M239.15,212.42l-56-112a8,8,0,0,0-14.31,0l-21.71,43.43A88,88,0,0,1,100,126.93,103.65,103.65,0,0,0,127.69,64H152a8,8,0,0,0,0-16H96V32a8,8,0,0,0-16,0V48H24a8,8,0,0,0,0,16h87.63A87.76,87.76,0,0,1,88,116.35a87.74,87.74,0,0,1-19-31,8,8,0,1,0-15.08,5.34A103.63,103.63,0,0,0,76,127a87.55,87.55,0,0,1-52,17,8,8,0,0,0,0,16,103.46,103.46,0,0,0,64-22.08,104.18,104.18,0,0,0,51.44,21.31l-26.6,53.19a8,8,0,0,0,14.31,7.16L140.94,192h70.11l13.79,27.58A8,8,0,0,0,232,224a8,8,0,0,0,7.15-11.58ZM148.94,176,176,121.89,203.05,176Z",
                label: AppStrings.language,
                index: 3,
                isActive: currentIndex == 3,
              ),
              // Profile
              _buildRegularNavItem(
                context,
                svgPath: "M230.92,212c-15.23-26.33-38.7-45.21-66.09-54.16a72,72,0,1,0-73.66,0C63.78,166.78,40.31,185.66,25.08,212a8,8,0,1,0,13.85,8c18.84-32.56,52.14-52,89.07-52s70.23,19.44,89.07,52a8,8,0,1,0,13.85-8ZM72,96a56,56,0,1,1,56,56A56.06,56.06,0,0,1,72,96Z",
                label: AppStrings.profile,
                index: 4,
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Regular navigation items (Home, Maps, Language, Profile)
  Widget _buildRegularNavItem(
    BuildContext context, {
    required String svgPath,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(
                AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
              ),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.l),
                ),
              ),
              child: SvgPicture.string(
                '<svg viewBox="0 0 256 256" xmlns="http://www.w3.org/2000/svg"><path d="$svgPath"/></svg>',
                width: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                height: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                colorFilter: ColorFilter.mode(
                  isActive ? AppColors.primary : AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs)),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xs),
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      ),
    );
  }

  // Special camera button - highlighted and prominent
  Widget _buildCameraButton(BuildContext context) {
    final bool isActive = currentIndex == 1;
    
    return Flexible(
      child: GestureDetector(
        onTap: () => onTap(1),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Camera button elevated above regular items
          Container(
            width: ResponsiveUtils.getCameraButtonSize(context),
            height: ResponsiveUtils.getCameraButtonSize(context),
            padding: EdgeInsets.all(
              AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs) / 2,
            ),
            margin: EdgeInsets.only(
              bottom: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s) * 0.75,
            ), // Push button up slightly
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.primaryDark,
                  ],
                ),
              ),
              child: Center(
                child: SvgPicture.string(
                  '<svg viewBox="0 0 256 256" xmlns="http://www.w3.org/2000/svg"><path d="M208,56H180.28L166.65,35.56A8,8,0,0,0,160,32H96a8,8,0,0,0-6.65,3.56L75.71,56H48A24,24,0,0,0,24,80V192a24,24,0,0,0,24,24H208a24,24,0,0,0,24-24V80A24,24,0,0,0,208,56Zm8,136a8,8,0,0,1-8,8H48a8,8,0,0,1-8-8V80a8,8,0,0,1,8-8H80a8,8,0,0,0,6.66-3.56L100.28,48h55.43l13.63,20.44A8,8,0,0,0,176,72h32a8,8,0,0,1,8,8ZM128,88a44,44,0,1,0,44,44A44.05,44.05,0,0,0,128,88Zm0,72a28,28,0,1,1,28-28A28,28,0,0,1,128,160Z"/></svg>',
                  width: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                  height: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          // Camera label aligned with other items
          Text(
            AppStrings.camera,
            style: TextStyle(
              fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xs),
              fontWeight: FontWeight.w700,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ],
      ), 
      )
    );
  }
}
