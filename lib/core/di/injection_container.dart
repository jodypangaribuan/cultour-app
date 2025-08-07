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

  // Use cases - Home
  sl.registerLazySingleton(() => GetFeaturedAttractions(sl()));

  // Use cases - Camera
  sl.registerLazySingleton(() => DetectLandmark(sl()));
  sl.registerLazySingleton(() => CollectDigitalStamp(sl()));

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

  // Data sources - Home
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  // Data sources - Camera
  sl.registerLazySingleton<CameraLocalDataSource>(
    () => CameraLocalDataSourceImpl(),
  );

  // Services
  sl.registerLazySingleton(() => AIDetectionService());

  // External
  sl.registerLazySingleton(() => http.Client());
}
