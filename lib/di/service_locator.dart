import 'package:get_it/get_it.dart';
import '../services/weather_service.dart';
import '../repositories/weather_repository.dart';
import '../providers/weather_provider.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt.registerLazySingleton<WeatherService>(() => WeatherService());

  // Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepository(getIt<WeatherService>()),
  );

  // Providers
  getIt.registerFactory<WeatherProvider>(
    () => WeatherProvider(getIt<WeatherRepository>()),
  );
}
