import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // API dari openweather
  static const String _apiKey = 'bb78566203b46c6d0372ed815736fba4';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Map<String, dynamic>> fetchCurrentWeatherByCoords(
    double lat,
    double lon, {
    String units = 'metric',
  }) async {
    final url = Uri.parse(
      '$_baseUrl/weather?lat=$lat&lon=$lon&units=$units&appid=$_apiKey',
    );
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return json.decode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load weather: ${res.statusCode}');
    }
  }
}
