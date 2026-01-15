class Weather {
  final String cityName;
  final double temp;
  final String description;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.cityName,
    required this.temp,
    required this.description,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temp: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
