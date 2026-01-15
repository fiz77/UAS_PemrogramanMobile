import '../services/weather_service.dart';
import '../models/weather.dart';

class WeatherRepository {
  final WeatherService service;
  WeatherRepository(this.service);

  Future<Weather> getWeatherByCoords(
    double lat,
    double lon, {
    String units = 'metric',
  }) async {
    final json = await service.fetchCurrentWeatherByCoords(
      lat,
      lon,
      units: units,
    );
    return Weather.fromJson(json);
  }
}
