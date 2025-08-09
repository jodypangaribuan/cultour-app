import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_featured_attractions.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

import '../../features/camera/data/datasources/camera_local_datasource.dart';
import '../../features/camera/data/repositories/camera_repository_impl.dart';
import '../../features/camera/data/services/ai_detection_service.dart';
import '../../features/camera/domain/repositories/camera_repository.dart';
import '../../features/camera/domain/usecases/detect_landmark.dart';
import '../../features/camera/domain/usecases/collect_digital_stamp.dart';
import '../../features/camera/presentation/bloc/camera_bloc.dart';

import '../../features/language/data/services/google_translate_service.dart';
import '../../features/language/data/repositories/translation_repository_impl.dart';
import '../../features/language/domain/repositories/translation_repository.dart';
import '../../features/language/domain/usecases/translate_text.dart';
import '../../features/language/domain/usecases/detect_language.dart';
import '../../features/language/presentation/bloc/translation_bloc.dart';

import '../../features/maps/data/datasources/maps_remote_datasource.dart';
import '../../features/maps/data/repositories/maps_repository_impl.dart';
import '../../features/maps/domain/repositories/maps_repository.dart';
import '../../features/maps/domain/usecases/get_directions.dart';
import '../../features/maps/domain/usecases/get_nearby_places.dart';
import '../../features/maps/domain/usecases/get_place_details.dart';
import '../../features/maps/domain/usecases/get_place_predictions.dart';
import '../../features/maps/presentation/bloc/maps_bloc.dart';
import '../config/api_config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Home
  sl.registerFactory(
    () => HomeBloc(getFeaturedAttractions: sl()),
  );

  // Features - Camera
  sl.registerFactory(
    () => CameraBloc(
      detectLandmark: sl(),
      collectDigitalStamp: sl(),
    ),
  );

  // Features - Language/Translation
  sl.registerFactory(
    () => TranslationBloc(
      translateText: sl(),
      detectLanguage: sl(),
    ),
  );

  // Features - Maps
  sl.registerFactory(
    () => MapsBloc(
      getPlacePredictions: sl(),
      getPlaceDetails: sl(),
      getNearbyPlaces: sl(),
      getDirections: sl(),
    ),
  );

  // Use cases - Home
  sl.registerLazySingleton(() => GetFeaturedAttractions(sl()));

  // Use cases - Camera
  sl.registerLazySingleton(() => DetectLandmark(sl()));
  sl.registerLazySingleton(() => CollectDigitalStamp(sl()));

  // Use cases - Language/Translation
  sl.registerLazySingleton(() => TranslateText(sl()));
  sl.registerLazySingleton(() => DetectLanguage(sl()));

  // Use cases - Maps
  sl.registerLazySingleton(() => GetPlacePredictions(sl()));
  sl.registerLazySingleton(() => GetPlaceDetails(sl()));
  sl.registerLazySingleton(() => GetNearbyPlaces(sl()));
  sl.registerLazySingleton(() => GetDirections(sl()));

  // Repositories - Home
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  // Repositories - Camera
  sl.registerLazySingleton<CameraRepository>(
    () => CameraRepositoryImpl(
      aiDetectionService: sl(),
      localDataSource: sl(),
    ),
  );

  // Repositories - Language/Translation
  sl.registerLazySingleton<TranslationRepository>(
    () => TranslationRepositoryImpl(translateService: sl()),
  );

  // Repositories - Maps
  sl.registerLazySingleton<MapsRepository>(
    () => MapsRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources - Home
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  // Data sources - Camera
  sl.registerLazySingleton<CameraLocalDataSource>(
    () => CameraLocalDataSourceImpl(),
  );

  // Data sources - Maps
  sl.registerLazySingleton<MapsRemoteDataSource>(
    () => MapsRemoteDataSourceImpl(
      client: sl(),
      apiKey: ApiConfig.googleMapsApiKey,
    ),
  );

  // Services
  sl.registerLazySingleton(() => AIDetectionService());
  
  // Google Translate Service
  sl.registerLazySingleton(() => GoogleTranslateService(
    apiKey: ApiConfig.googleTranslateApiKey,
  ));

  // External
  sl.registerLazySingleton(() => http.Client());
}
