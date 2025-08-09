import 'package:flutter/material.dart';
import 'responsive_utils.dart';
import '../constants/dimensions.dart';
import '../constants/colors.dart';

/// A test widget to demonstrate and validate responsive behavior
/// This can be used during development to test responsive layouts
class ResponsiveTestWidget extends StatelessWidget {
  const ResponsiveTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Test'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeviceInfo(context),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.l)),
            _buildDimensionTests(context),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.l)),
            _buildGridTest(context),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.l)),
            _buildButtonTests(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            _buildInfoRow(context, 'Device Type:', context.deviceType.name),
            _buildInfoRow(context, 'Screen Width:', '${context.screenWidth.toInt()}px'),
            _buildInfoRow(context, 'Screen Height:', '${context.screenHeight.toInt()}px'),
            _buildInfoRow(context, 'Is Mobile:', context.isMobile.toString()),
            _buildInfoRow(context, 'Is Tablet:', context.isTablet.toString()),
            _buildInfoRow(context, 'Is Desktop:', context.isDesktop.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.xs),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionTests(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Dimensions',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            Wrap(
              spacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
              runSpacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
              children: [
                _buildDimensionBox(context, 'XS', ResponsivePaddingSize.xs, AppColors.error),
                _buildDimensionBox(context, 'S', ResponsivePaddingSize.s, AppColors.accent),
                _buildDimensionBox(context, 'M', ResponsivePaddingSize.m, AppColors.primary),
                _buildDimensionBox(context, 'L', ResponsivePaddingSize.l, AppColors.primaryLight),
                _buildDimensionBox(context, 'XL', ResponsivePaddingSize.xl, AppColors.primaryDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDimensionBox(BuildContext context, String label, ResponsivePaddingSize size, Color color) {
    final dimension = AppDimensions.getResponsivePadding(context, size);
    return Container(
      width: 60 + dimension,
      height: 60 + dimension,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(
          AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.s),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.s),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              '${dimension.toInt()}',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xs),
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridTest(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Grid',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            Text(
              'Columns: ${context.responsiveCrossAxisCount(mobile: 2, tablet: 3, desktop: 4)}',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.m),
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            SizedBox(
              height: 200,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.responsiveCrossAxisCount(mobile: 2, tablet: 3, desktop: 4),
                  crossAxisSpacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                  mainAxisSpacing: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s),
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.s),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonTests(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(
          AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Responsive Buttons',
              style: TextStyle(
                fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                minimumSize: Size(
                  double.infinity,
                  ResponsiveUtils.getResponsiveButtonHeight(context),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.getResponsiveBorderRadius(context, ResponsiveRadiusSize.m),
                  ),
                ),
              ),
              child: Text(
                'Responsive Button',
                style: TextStyle(
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
            Row(
              children: [
                Container(
                  width: ResponsiveUtils.getControlButtonSize(context),
                  height: ResponsiveUtils.getControlButtonSize(context),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getControlButtonSize(context) / 2,
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.s),
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m)),
                Container(
                  width: ResponsiveUtils.getCameraButtonSize(context),
                  height: ResponsiveUtils.getCameraButtonSize(context),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
