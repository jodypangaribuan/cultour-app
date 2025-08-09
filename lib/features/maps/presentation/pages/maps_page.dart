import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimensions.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController? _mapController;
  bool _isMapReady = false;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filterTags = ['Restaurants', 'Museums', 'Parks'];
  LatLng? _currentPosition;
  LatLng? _searchedPosition;
  final Set<Marker> _markers = {};

  static const LatLng _defaultJakarta = LatLng(-6.200000, 106.816666);
  bool _mapError = false;
  String _mapErrorMsg = '';

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
  // Set default sementara biar Map bisa render
  setState(() {
    _currentPosition = _defaultJakarta;
  });

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    // Pakai default lokasi Jakarta
    _setDefaultLocation();
    return;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng newPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = newPosition;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: newPosition,
          infoWindow: const InfoWindow(title: 'Lokasi Anda'),
        ),
      );
    });

    if (_isMapReady && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLng(newPosition));
    }
  } catch (e) {
    print('Error getting position: $e');
    _setDefaultLocation();
  }
}

void _setDefaultLocation() {
  setState(() {
    _currentPosition = _defaultJakarta;
    _markers.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('defaultLocation'),
        position: _defaultJakarta,
        infoWindow: const InfoWindow(title: 'Default Jakarta'),
      ),
    );
  });
}

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;
    try {
      print('Mencari lokasi: $query');
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final LatLng searchedLatLng = LatLng(locations.first.latitude, locations.first.longitude);
        print('Lokasi ditemukan: $searchedLatLng');
        setState(() {
          _searchedPosition = searchedLatLng;
          // Marker lokasi awal tetap, marker pencarian ditambah/ganti
          _markers.removeWhere((m) => m.markerId.value == 'searchedLocation');
          _markers.add(
            Marker(
              markerId: const MarkerId('searchedLocation'),
              position: searchedLatLng,
              infoWindow: InfoWindow(title: query),
            ),
          );
        });
        if (_isMapReady && _mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLngZoom(searchedLatLng, 16),
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lokasi "$query" ditemukan!'),
            backgroundColor: AppColors.primary,
          ),
        );
      } else {
        print('Lokasi tidak ditemukan: $query');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Lokasi tidak ditemukan!'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } catch (e) {
      print('Error searching location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Terjadi kesalahan saat mencari lokasi!'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Kamera default ke lokasi awal, jika ada hasil pencarian pindah ke sana
    final LatLng mapCenter = _searchedPosition ?? _currentPosition ?? _defaultJakarta;
    return Scaffold(
      body: Stack(
        children: [
          Builder(
            builder: (context) {
              try {
                return GoogleMap(
                  key: const ValueKey('map'),
                  initialCameraPosition: CameraPosition(
                    target: mapCenter,
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                    setState(() {
                      _isMapReady = true;
                      _mapError = false;
                      _mapErrorMsg = '';
                    });
                    // Jika hasil pencarian sudah ada, langsung pindah kamera ke sana
                    if (_searchedPosition != null) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        _mapController?.animateCamera(
                          CameraUpdate.newLatLngZoom(_searchedPosition!, 16),
                        );
                      });
                    }
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: _markers,
                );
              } catch (e) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _mapError = true;
                    _mapErrorMsg = 'Gagal memuat Google Maps: $e\nKemungkinan API Key salah, permission belum benar, atau device tidak support.';
                  });
                });
                return const SizedBox.shrink();
              }
            },
          ),
          if (_mapError)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.85),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        _mapErrorMsg.isNotEmpty
                            ? _mapErrorMsg
                            : 'Gagal memuat Google Maps.\nCek API Key dan permission lokasi.',
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_currentPosition == null && !_mapError)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Mengambil lokasi...',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          SafeArea(
            child: Column(
              children: [
                _buildTopSection(),
                const Spacer(),
                _buildBottomSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          Expanded(
            child: Container(
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
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: AppDimensions.paddingM),
                    child: Icon(Icons.search, color: Colors.grey, size: 20),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search places...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _searchLocation(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          _circleButton(Icons.menu, () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Menu akan segera hadir!'),
                backgroundColor: AppColors.primary,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filterTags
                    .map((tag) => Container(
                          margin: const EdgeInsets.only(
                              right: AppDimensions.paddingS),
                          child: FilterChip(
                            label: Text(tag),
                            onSelected: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$tag filter coming soon!'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Column(
            children: [
              _circleButton(Icons.add, () {
                if (_isMapReady) {
                  _mapController?.animateCamera(CameraUpdate.zoomIn());
                }
              }),
              const SizedBox(height: 8),
              _circleButton(Icons.remove, () {
                if (_isMapReady) {
                  _mapController?.animateCamera(CameraUpdate.zoomOut());
                }
              }),
              const SizedBox(height: 8),
              _circleButton(Icons.my_location, () {
                if (_isMapReady && _currentPosition != null) {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLng(_currentPosition!),
                  );
                  setState(() {
                    _searchedPosition = null;
                  });
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(bottom: 4),
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
      child: IconButton(
        icon: Icon(icon, size: 20),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
      ),
    );
  }
}
// Tidak perlu perubahan kode untuk error ini.
