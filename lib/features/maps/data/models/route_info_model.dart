import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../../domain/entities/route_info.dart';

class RouteInfoModel extends RouteInfo {
  const RouteInfoModel({
    required super.polylinePoints,
    required super.distance,
    required super.duration,
    super.durationInTraffic,
    required super.steps,
  });

  factory RouteInfoModel.fromJson(Map<String, dynamic> json) {
    final routes = json['routes'] as List;
    if (routes.isEmpty) {
      return const RouteInfoModel(
        polylinePoints: [],
        distance: '0 km',
        duration: '0 mins',
        steps: [],
      );
    }

    final route = routes.first;
    final legs = route['legs'] as List;
    final leg = legs.first;
    
    final steps = (leg['steps'] as List)
        .map((step) => RouteStepModel.fromJson(step))
        .toList();

    // Decode polyline points
    final overviewPolyline = route['overview_polyline']['points'] as String;
    final polylinePoints = PolylinePoints()
        .decodePolyline(overviewPolyline)
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();

    return RouteInfoModel(
      polylinePoints: polylinePoints,
      distance: leg['distance']['text'],
      duration: leg['duration']['text'],
      durationInTraffic: leg['duration_in_traffic']?['text'],
      steps: steps,
    );
  }
}

class RouteStepModel extends RouteStep {
  const RouteStepModel({
    required super.instruction,
    required super.distance,
    required super.duration,
    required super.startLocation,
    required super.endLocation,
    super.maneuver,
  });

  factory RouteStepModel.fromJson(Map<String, dynamic> json) {
    final startLoc = json['start_location'];
    final endLoc = json['end_location'];
    
    return RouteStepModel(
      instruction: _stripHtmlTags(json['html_instructions'] ?? ''),
      distance: json['distance']['text'],
      duration: json['duration']['text'],
      startLocation: LatLng(
        startLoc['lat'].toDouble(),
        startLoc['lng'].toDouble(),
      ),
      endLocation: LatLng(
        endLoc['lat'].toDouble(),
        endLoc['lng'].toDouble(),
      ),
      maneuver: json['maneuver'],
    );
  }

  static String _stripHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}
