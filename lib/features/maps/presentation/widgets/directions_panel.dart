import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../domain/entities/route_info.dart';

class DirectionsPanel extends StatelessWidget {
  final RouteInfo routeInfo;
  final VoidCallback? onClose;
  final VoidCallback? onStartNavigation;

  const DirectionsPanel({
    super.key,
    required this.routeInfo,
    this.onClose,
    this.onStartNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Row(
              children: [
                const Icon(Icons.directions, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${routeInfo.distance} • ${routeInfo.duration}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (routeInfo.durationInTraffic != null)
                        Text(
                          'In traffic: ${routeInfo.durationInTraffic}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onStartNavigation,
                    icon: const Icon(Icons.navigation, size: 18),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Steps list
          if (routeInfo.steps.isNotEmpty) ...[
            const Divider(),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: routeInfo.steps.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final step = routeInfo.steps[index];
                  return ListTile(
                    dense: true,
                    leading: _getManeuverIcon(step.maneuver),
                    title: Text(
                      step.instruction,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${step.distance} • ${step.duration}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
          
          const SizedBox(height: AppDimensions.paddingM),
        ],
      ),
    );
  }

  Widget _getManeuverIcon(String? maneuver) {
    IconData iconData;
    switch (maneuver) {
      case 'turn-right':
        iconData = Icons.turn_right;
        break;
      case 'turn-left':
        iconData = Icons.turn_left;
        break;
      case 'straight':
        iconData = Icons.straight;
        break;
      case 'ramp-right':
        iconData = Icons.ramp_right;
        break;
      case 'ramp-left':
        iconData = Icons.ramp_left;
        break;
      case 'merge':
        iconData = Icons.merge;
        break;
      case 'fork-right':
      case 'fork-left':
        iconData = Icons.call_split;
        break;
      case 'roundabout-right':
      case 'roundabout-left':
        iconData = Icons.roundabout_right;
        break;
      default:
        iconData = Icons.navigation;
    }
    
    return Icon(iconData, color: Colors.grey, size: 20);
  }
}
