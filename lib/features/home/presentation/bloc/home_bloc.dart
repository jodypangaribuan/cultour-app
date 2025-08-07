import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/attraction.dart';
import '../../domain/usecases/get_featured_attractions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetFeaturedAttractions _getFeaturedAttractions;

  HomeBloc({
    required GetFeaturedAttractions getFeaturedAttractions,
  })  : _getFeaturedAttractions = getFeaturedAttractions,
        super(const HomeInitial()) {
    on<GetFeaturedAttractionsEvent>(_onGetFeaturedAttractions);
  }

  Future<void> _onGetFeaturedAttractions(
    GetFeaturedAttractionsEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final result = await _getFeaturedAttractions();

    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (attractions) => emit(HomeLoaded(attractions)),
    );
  }
}
