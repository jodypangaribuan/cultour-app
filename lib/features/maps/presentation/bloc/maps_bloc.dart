import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_directions.dart' as usecases;
import '../../domain/usecases/get_nearby_places.dart' as usecases;
import '../../domain/usecases/get_place_details.dart';
import '../../domain/usecases/get_place_predictions.dart' as usecases;
import 'maps_event.dart';
import 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final usecases.GetPlacePredictions getPlacePredictions;
  final GetPlaceDetails getPlaceDetails;
  final usecases.GetNearbyPlaces getNearbyPlaces;
  final usecases.GetDirections getDirections;

  MapsBloc({
    required this.getPlacePredictions,
    required this.getPlaceDetails,
    required this.getNearbyPlaces,
    required this.getDirections,
  }) : super(const MapsInitial()) {
    on<GetPlacePredictionsEvent>(_onGetPlacePredictions);
    on<SelectPlace>(_onSelectPlace);
    on<GetNearbyPlacesEvent>(_onGetNearbyPlaces);
    on<GetDirectionsEvent>(_onGetDirections);
    on<ClearSearchResults>(_onClearSearchResults);
    on<ClearDirections>(_onClearDirections);
  }

  Future<void> _onGetPlacePredictions(
    GetPlacePredictionsEvent event,
    Emitter<MapsState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      if (state is MapsLoaded) {
        emit((state as MapsLoaded).copyWith(predictions: []));
      }
      return;
    }

    final result = await getPlacePredictions(event.query);

    result.fold(
      (failure) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            errorMessage: failure.message,
            predictions: [],
          ));
        } else {
          emit(MapsError(failure.message));
        }
      },
      (predictions) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            predictions: predictions,
            clearErrorMessage: true,
          ));
        } else {
          emit(MapsLoaded(predictions: predictions));
        }
      },
    );
  }

  Future<void> _onSelectPlace(
    SelectPlace event,
    Emitter<MapsState> emit,
  ) async {
    if (state is MapsLoaded) {
      emit((state as MapsLoaded).copyWith(predictions: []));
    }

    final result = await getPlaceDetails(event.placeId);

    result.fold(
      (failure) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            errorMessage: failure.message,
          ));
        } else {
          emit(MapsError(failure.message));
        }
      },
      (place) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            selectedPlace: place,
            clearErrorMessage: true,
          ));
        } else {
          emit(MapsLoaded(selectedPlace: place));
        }
      },
    );
  }

  Future<void> _onGetNearbyPlaces(
    GetNearbyPlacesEvent event,
    Emitter<MapsState> emit,
  ) async {
    final result = await getNearbyPlaces(
      location: event.location,
      radius: event.radius,
      type: event.type,
    );

    result.fold(
      (failure) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            errorMessage: failure.message,
          ));
        } else {
          emit(MapsError(failure.message));
        }
      },
      (places) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            nearbyPlaces: places,
            clearErrorMessage: true,
          ));
        } else {
          emit(MapsLoaded(nearbyPlaces: places));
        }
      },
    );
  }

  Future<void> _onGetDirections(
    GetDirectionsEvent event,
    Emitter<MapsState> emit,
  ) async {
    final result = await getDirections(
      origin: event.origin,
      destination: event.destination,
      travelMode: event.travelMode,
    );

    result.fold(
      (failure) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            errorMessage: failure.message,
          ));
        } else {
          emit(MapsError(failure.message));
        }
      },
      (routeInfo) {
        if (state is MapsLoaded) {
          emit((state as MapsLoaded).copyWith(
            routeInfo: routeInfo,
            clearErrorMessage: true,
          ));
        } else {
          emit(MapsLoaded(routeInfo: routeInfo));
        }
      },
    );
  }

  void _onClearSearchResults(
    ClearSearchResults event,
    Emitter<MapsState> emit,
  ) {
    if (state is MapsLoaded) {
      emit((state as MapsLoaded).copyWith(
        predictions: [],
        searchResults: [],
        clearSelectedPlace: true,
        clearErrorMessage: true,
      ));
    }
  }

  void _onClearDirections(
    ClearDirections event,
    Emitter<MapsState> emit,
  ) {
    if (state is MapsLoaded) {
      emit((state as MapsLoaded).copyWith(
        clearRouteInfo: true,
        clearErrorMessage: true,
      ));
    }
  }
}
