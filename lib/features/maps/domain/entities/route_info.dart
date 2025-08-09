import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteInfo extends Equatable {
  final List<LatLng> polylinePoints;
  final String distance;
  final String duration;
  final String? durationInTraffic;
  final List<RouteStep> steps;

  const RouteInfo({
    required this.polylinePoints,
    required this.distance,
    required this.duration,
    this.durationInTraffic,
    required this.steps,
  });

  @override
  List<Object?> get props => [
        polylinePoints,
        distance,
        duration,
        durationInTraffic,
        steps,
      ];
}

class RouteStep extends Equatable {
  final String instruction;
  final String distance;
  final String duration;
  final LatLng startLocation;
  final LatLng endLocation;
  final String? maneuver;

  const RouteStep({
    required this.instruction,
    required this.distance,
    required this.duration,
    required this.startLocation,
    required this.endLocation,
    this.maneuver,
  });

  @override
  List<Object?> get props => [
        instruction,
        distance,
        duration,
        startLocation,
        endLocation,
        maneuver,
      ];
}
