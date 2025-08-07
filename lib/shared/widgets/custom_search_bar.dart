import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/dimensions.dart';
import '../../core/constants/strings.dart';

class CustomSearchBar extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Icon(
              Icons.search,
              color: AppColors.textSecondary,
              size: AppDimensions.iconS + 4,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText ?? AppStrings.searchPlaceholder,
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppDimensions.fontL,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppDimensions.fontL,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
