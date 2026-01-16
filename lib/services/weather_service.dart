import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // API dari openweather
  static const String _apiKey = 'enter ur api key here';
  static const String _baseUrl = 'put ur url here';

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

