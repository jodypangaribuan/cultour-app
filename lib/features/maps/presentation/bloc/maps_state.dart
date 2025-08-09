import 'package:equatable/equatable.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/place_prediction.dart';
import '../../domain/entities/route_info.dart';

abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object?> get props => [];
}

class MapsInitial extends MapsState {
  const MapsInitial();
}

class MapsLoading extends MapsState {
  const MapsLoading();
}

class MapsLoaded extends MapsState {
  final List<PlacePrediction> predictions;
  final List<Place> searchResults;
  final List<Place> nearbyPlaces;
  final Place? selectedPlace;
  final RouteInfo? routeInfo;
  final String? errorMessage;

  const MapsLoaded({
    this.predictions = const [],
    this.searchResults = const [],
    this.nearbyPlaces = const [],
    this.selectedPlace,
    this.routeInfo,
    this.errorMessage,
  });

  MapsLoaded copyWith({
    List<PlacePrediction>? predictions,
    List<Place>? searchResults,
    List<Place>? nearbyPlaces,
    Place? selectedPlace,
    RouteInfo? routeInfo,
    String? errorMessage,
    bool clearSelectedPlace = false,
    bool clearRouteInfo = false,
    bool clearErrorMessage = false,
  }) {
    return MapsLoaded(
      predictions: predictions ?? this.predictions,
      searchResults: searchResults ?? this.searchResults,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      selectedPlace: clearSelectedPlace ? null : (selectedPlace ?? this.selectedPlace),
      routeInfo: clearRouteInfo ? null : (routeInfo ?? this.routeInfo),
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        predictions,
        searchResults,
        nearbyPlaces,
        selectedPlace,
        routeInfo,
        errorMessage,
      ];
}

class MapsError extends MapsState {
  final String message;

  const MapsError(this.message);

  @override
  List<Object> get props => [message];
}
