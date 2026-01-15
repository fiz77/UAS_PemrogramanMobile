import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/weather_repository.dart';
import '../models/weather.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository repository;
  Weather? _weather;
  bool _loading = false;
  bool get isLoading => _loading;
  String _units = 'metric'; // metric or imperial
  double? lastLat;
  double? lastLon;

  WeatherProvider(this.repository) {
    _loadPrefs();
  }

  Weather? get weather => _weather;
  bool get loading => _loading;
  String get units => _units;

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _units = prefs.getString('units') ?? 'metric';
    lastLat = prefs.getDouble('lastLat');
    lastLon = prefs.getDouble('lastLon');
    notifyListeners();
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (lastLat != null) prefs.setDouble('lastLat', lastLat!);
    if (lastLon != null) prefs.setDouble('lastLon', lastLon!);
    prefs.setString('units', _units);
  }

  Future<void> toggleUnits() async {
    _units = _units == 'metric' ? 'imperial' : 'metric';
    await _savePrefs();
    if (lastLat != null && lastLon != null) {
      await fetchWeather(lastLat!, lastLon!);
    } else {
      notifyListeners();
    }
  }

  Future<void> fetchWeather(double lat, double lon) async {
    _loading = true;
    notifyListeners();
    try {
      lastLat = lat;
      lastLon = lon;
      final w = await repository.getWeatherByCoords(lat, lon, units: _units);
      _weather = w;
      await _savePrefs();
    } catch (e) {
      // handle error (could add error state)
      rethrow;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> refreshUsingDeviceLocation() async {
    final pos = await determinePosition();
    await fetchWeather(pos.latitude, pos.longitude);
  }
}
