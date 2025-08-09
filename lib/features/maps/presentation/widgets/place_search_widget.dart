import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/dimensions.dart';
import '../../domain/entities/place_prediction.dart';
import '../bloc/maps_bloc.dart';
import '../bloc/maps_event.dart';
import '../bloc/maps_state.dart';

class PlaceSearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onClear;
  final Function(PlacePrediction)? onPlaceSelected;

  const PlaceSearchWidget({
    super.key,
    required this.controller,
    this.onClear,
    this.onPlaceSelected,
  });

  @override
  State<PlaceSearchWidget> createState() => _PlaceSearchWidgetState();
}

class _PlaceSearchWidgetState extends State<PlaceSearchWidget> {
  bool _showPredictions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  controller: widget.controller,
                  decoration: const InputDecoration(
                    hintText: 'Search places...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: AppDimensions.paddingM,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.trim().isNotEmpty) {
                      context.read<MapsBloc>().add(GetPlacePredictionsEvent(value));
                      setState(() {
                        _showPredictions = true;
                      });
                    } else {
                      setState(() {
                        _showPredictions = false;
                      });
                    }
                  },
                  onTap: () {
                    if (widget.controller.text.trim().isNotEmpty) {
                      setState(() {
                        _showPredictions = true;
                      });
                    }
                  },
                ),
              ),
              if (widget.controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
                  onPressed: () {
                    widget.controller.clear();
                    setState(() {
                      _showPredictions = false;
                    });
                    context.read<MapsBloc>().add(const ClearSearchResults());
                    widget.onClear?.call();
                  },
                ),
            ],
          ),
        ),
        if (_showPredictions) _buildPredictionsList(),
      ],
    );
  }

  Widget _buildPredictionsList() {
    return BlocBuilder<MapsBloc, MapsState>(
      builder: (context, state) {
        if (state is MapsLoaded && state.predictions.isNotEmpty) {
          return Container(
            margin: const EdgeInsets.only(top: 8),
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.predictions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final prediction = state.predictions[index];
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Colors.grey),
                  title: Text(
                    prediction.mainText ?? prediction.description,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: prediction.secondaryText != null
                      ? Text(
                          prediction.secondaryText!,
                          style: const TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  onTap: () {
                    widget.controller.text = prediction.description;
                    setState(() {
                      _showPredictions = false;
                    });
                    context.read<MapsBloc>().add(SelectPlace(prediction.placeId));
                    widget.onPlaceSelected?.call(prediction);
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
