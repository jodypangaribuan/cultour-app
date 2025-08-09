import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/error/failures.dart';
import '../models/place_model.dart';
import '../models/place_prediction_model.dart';
import '../models/route_info_model.dart';

abstract class MapsRemoteDataSource {
  Future<List<PlacePredictionModel>> getPlacePredictions(String query);
  Future<PlaceModel> getPlaceDetails(String placeId);
  Future<List<PlaceModel>> getNearbyPlaces({
    required LatLng location,
    required int radius,
    String? type,
  });
  Future<RouteInfoModel> getDirections({
    required LatLng origin,
    required LatLng destination,
    String? travelMode,
  });
  Future<List<PlaceModel>> searchPlaces({
    required String query,
    LatLng? location,
    int? radius,
  });
}

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  final http.Client client;
  final String apiKey;

  MapsRemoteDataSourceImpl({
    required this.client,
    required this.apiKey,
  });

  @override
  Future<List<PlacePredictionModel>> getPlacePredictions(String query) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json'
      '?input=${Uri.encodeComponent(query)}'
      '&key=$apiKey',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List;
      return predictions
          .map((prediction) => PlacePredictionModel.fromJson(prediction))
          .toList();
    } else {
      throw ServerFailure('Failed to get place predictions');
    }
  }

  @override
  Future<PlaceModel> getPlaceDetails(String placeId) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/details/json'
      '?place_id=$placeId'
      '&fields=name,rating,formatted_phone_number,website,formatted_address,geometry,photos,opening_hours,price_level,types'
      '&key=$apiKey',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PlaceModel.fromPlaceDetailsJson(data);
    } else {
      throw ServerFailure('Failed to get place details');
    }
  }

  @override
  Future<List<PlaceModel>> getNearbyPlaces({
    required LatLng location,
    required int radius,
    String? type,
  }) async {
    final typeParam = type != null ? '&type=$type' : '';
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${location.latitude},${location.longitude}'
      '&radius=$radius'
      '$typeParam'
      '&key=$apiKey',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((place) => PlaceModel.fromJson(place)).toList();
    } else {
      throw ServerFailure('Failed to get nearby places');
    }
  }

  @override
  Future<RouteInfoModel> getDirections({
    required LatLng origin,
    required LatLng destination,
    String? travelMode,
  }) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
      '?origin=${origin.latitude},${origin.longitude}'
      '&destination=${destination.latitude},${destination.longitude}'
      '&mode=${travelMode ?? 'driving'}'
      '&key=$apiKey',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RouteInfoModel.fromJson(data);
    } else {
      throw ServerFailure('Failed to get directions');
    }
  }

  @override
  Future<List<PlaceModel>> searchPlaces({
    required String query,
    LatLng? location,
    int? radius,
  }) async {
    String url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'
        '?query=${Uri.encodeComponent(query)}';
    
    if (location != null) {
      url += '&location=${location.latitude},${location.longitude}';
    }
    
    if (radius != null) {
      url += '&radius=$radius';
    }
    
    url += '&key=$apiKey';

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((place) => PlaceModel.fromJson(place)).toList();
    } else {
      throw ServerFailure('Failed to search places');
    }
  }
}
