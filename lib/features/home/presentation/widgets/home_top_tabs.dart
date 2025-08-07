import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/constants/strings.dart';

class HomeTopTabs extends StatefulWidget {
  const HomeTopTabs({super.key});

  @override
  State<HomeTopTabs> createState() => _HomeTopTabsState();
}

class _HomeTopTabsState extends State<HomeTopTabs> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'icon': Icons.camera_alt, 'label': AppStrings.aiCamera},
    {'icon': Icons.translate, 'label': AppStrings.languageTutor},
    {'icon': Icons.location_on, 'label': AppStrings.nearbyStamps},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
        child: Row(
          children: _tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isActive = index == _selectedIndex;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isActive ? AppColors.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        tab['icon'] as IconData,
                        color: isActive ? AppColors.primary : AppColors.textSecondary,
                        size: AppDimensions.iconM,
                      ),
                      const SizedBox(height: AppDimensions.paddingS),
                      Text(
                        tab['label'] as String,
                        style: TextStyle(
                          fontSize: AppDimensions.fontS,
                          fontWeight: FontWeight.w600,
                          color: isActive ? AppColors.primary : AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
