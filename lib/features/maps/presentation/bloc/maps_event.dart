import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object?> get props => [];
}

class SearchPlaces extends MapsEvent {
  final String query;

  const SearchPlaces(this.query);

  @override
  List<Object> get props => [query];
}

class GetPlacePredictionsEvent extends MapsEvent {
  final String query;

  const GetPlacePredictionsEvent(this.query);

  @override
  List<Object> get props => [query];
}

class SelectPlace extends MapsEvent {
  final String placeId;

  const SelectPlace(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class GetDirectionsEvent extends MapsEvent {
  final LatLng origin;
  final LatLng destination;
  final String? travelMode;

  const GetDirectionsEvent({
    required this.origin,
    required this.destination,
    this.travelMode,
  });

  @override
  List<Object?> get props => [origin, destination, travelMode];
}

class GetNearbyPlacesEvent extends MapsEvent {
  final LatLng location;
  final int radius;
  final String? type;

  const GetNearbyPlacesEvent({
    required this.location,
    required this.radius,
    this.type,
  });

  @override
  List<Object?> get props => [location, radius, type];
}

class ClearSearchResults extends MapsEvent {
  const ClearSearchResults();
}

class ClearDirections extends MapsEvent {
  const ClearDirections();
}
