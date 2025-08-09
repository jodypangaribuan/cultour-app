import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/di/injection_container.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/route_info.dart';
import '../bloc/maps_bloc.dart';
import '../bloc/maps_event.dart';
import '../bloc/maps_state.dart';
import '../widgets/place_search_widget.dart';
import '../widgets/place_info_window.dart';
import '../widgets/directions_panel.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  
  Place? _selectedPlace;
  RouteInfo? _routeInfo;
  bool _showDirections = false;
  
  static const LatLng _defaultJakarta = LatLng(-6.200000, 106.816666);
  


  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied || 
          permission == LocationPermission.deniedForever) {
        _setDefaultLocation();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _updateCurrentLocationMarker();
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentPosition!),
        );
      }
    } catch (e) {
      print('Error getting location: $e');
      _setDefaultLocation();
    }
  }

  void _setDefaultLocation() {
    setState(() {
      _currentPosition = _defaultJakarta;
      _updateCurrentLocationMarker();
    });
  }

  void _updateCurrentLocationMarker() {
    _markers.removeWhere((m) => m.markerId.value == 'currentLocation');
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'Your Location'),
        ),
      );
    }
  }

  void _addPlaceMarker(Place place) {
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'selectedPlace');
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedPlace'),
          position: LatLng(place.latitude, place.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.address,
          ),
          onTap: () {
            setState(() {
              _selectedPlace = place;
            });
          },
        ),
      );
    });
  }

  void _addNearbyPlaceMarkers(List<Place> places) {
    setState(() {
      // Remove existing nearby markers
      _markers.removeWhere((m) => m.markerId.value.startsWith('nearby_'));
      
      // Add new markers
      for (int i = 0; i < places.length; i++) {
        final place = places[i];
        _markers.add(
          Marker(
            markerId: MarkerId('nearby_$i'),
            position: LatLng(place.latitude, place.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: place.address,
            ),
            onTap: () {
              setState(() {
                _selectedPlace = place;
              });
            },
          ),
        );
      }
    });
  }

  void _drawRoute(RouteInfo routeInfo) {
    setState(() {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: routeInfo.polylinePoints,
          color: AppColors.primary,
          width: 5,
          patterns: [],
        ),
      );
      _routeInfo = routeInfo;
      _showDirections = true;
    });
  }

  void _clearRoute() {
    setState(() {
      _polylines.clear();
      _routeInfo = null;
      _showDirections = false;
    });
  }

  void _onPlaceSelected(Place place) {
    _addPlaceMarker(place);
    setState(() {
      _selectedPlace = place;
    });
    
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(place.latitude, place.longitude),
          16,
        ),
      );
    }
  }

  void _getDirections() {
    if (_selectedPlace != null && _currentPosition != null) {
      context.read<MapsBloc>().add(
        GetDirectionsEvent(
          origin: _currentPosition!,
          destination: LatLng(_selectedPlace!.latitude, _selectedPlace!.longitude),
        ),
      );
    }
  }



  void _startNavigation() async {
    if (_selectedPlace != null) {
      final uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${_selectedPlace!.latitude},${_selectedPlace!.longitude}&travelmode=driving',
      );
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MapsBloc>(),
      child: Scaffold(
        body: BlocListener<MapsBloc, MapsState>(
          listener: (context, state) {
            if (state is MapsLoaded) {
              if (state.selectedPlace != null) {
                _onPlaceSelected(state.selectedPlace!);
              }
              if (state.nearbyPlaces.isNotEmpty) {
                _addNearbyPlaceMarkers(state.nearbyPlaces);
              }
              if (state.routeInfo != null) {
                _drawRoute(state.routeInfo!);
              }
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else if (state is MapsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Stack(
            children: [
              // Google Map
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentPosition ?? _defaultJakarta,
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                markers: _markers,
                polylines: _polylines,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (_) {
                  setState(() {
                    _selectedPlace = null;
                  });
                },
              ),

              // Search overlay
              SafeArea(
                child: Column(
                  children: [
                    // Search bar
                    Padding(
                      padding: EdgeInsets.all(
                        AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                      ),
                      child: PlaceSearchWidget(
                        controller: _searchController,
                        onClear: () {
                          setState(() {
                            _selectedPlace = null;
                          });
                          _clearRoute();
                        },
                        onPlaceSelected: (prediction) {
                          // The bloc will handle getting place details
                        },
                      ),
                    ),



                    const Spacer(),

                    // Place info window
                    if (_selectedPlace != null && !_showDirections)
                      PlaceInfoWindow(
                        place: _selectedPlace!,
                        onGetDirections: _getDirections,
                        onClose: () {
                          setState(() {
                            _selectedPlace = null;
                          });
                        },
                      ),

                    // Directions panel
                    if (_showDirections && _routeInfo != null)
                      DirectionsPanel(
                        routeInfo: _routeInfo!,
                        onClose: () {
                          _clearRoute();
                          context.read<MapsBloc>().add(const ClearDirections());
                        },
                        onStartNavigation: _startNavigation,
                      ),

                    // Control buttons
                    Padding(
                      padding: EdgeInsets.all(
                        AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              _buildControlButton(
                                Icons.add,
                                () {
                                  _mapController?.animateCamera(CameraUpdate.zoomIn());
                                },
                              ),
                              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
                              _buildControlButton(
                                Icons.remove,
                                () {
                                  _mapController?.animateCamera(CameraUpdate.zoomOut());
                                },
                              ),
                              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
                              _buildControlButton(
                                Icons.my_location,
                                () {
                                  if (_currentPosition != null) {
                                    _mapController?.animateCamera(
                                      CameraUpdate.newLatLng(_currentPosition!),
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.s)),
                              _buildControlButton(
                                Icons.layers,
                                () {
                                  _showMapTypeDialog();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    final buttonSize = ResponsiveUtils.getControlButtonSize(context);
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(buttonSize / 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon, 
          size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.s),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  void _showMapTypeDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(
            AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Map Type',
                style: TextStyle(
                  fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.xl),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.getResponsivePadding(context, ResponsivePaddingSize.m)),
              ListTile(
                leading: Icon(
                  Icons.map,
                  size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                ),
                title: Text(
                  'Normal',
                  style: TextStyle(
                    fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                  ),
                ),
                onTap: () {
                  // Change map type to normal
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.satellite,
                  size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                ),
                title: Text(
                  'Satellite',
                  style: TextStyle(
                    fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                  ),
                ),
                onTap: () {
                  // Change map type to satellite
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.terrain,
                  size: AppDimensions.getResponsiveIconSize(context, ResponsiveIconSize.m),
                ),
                title: Text(
                  'Terrain',
                  style: TextStyle(
                    fontSize: AppDimensions.getResponsiveFontSize(context, ResponsiveFontSize.l),
                  ),
                ),
                onTap: () {
                  // Change map type to terrain
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

