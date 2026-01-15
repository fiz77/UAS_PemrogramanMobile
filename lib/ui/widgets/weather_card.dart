import 'package:flutter/material.dart';
import '../../models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final String units;

  const WeatherCard({super.key, required this.weather, required this.units});

  @override
  Widget build(BuildContext context) {
    final unitSymbol = units == 'metric' ? 'C' : 'F';

    return Column(
      children: [
        /// Location
        Text(
          weather.cityName,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 24),

        /// Weather Icon (Hero)
        _WeatherIcon(description: weather.description),

        const SizedBox(height: 16),

        /// Temperature
        Text(
          '${weather.temp.round()}°$unitSymbol',
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        /// Description
        Text(
          weather.description,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const SizedBox(height: 24),

        /// Info Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _InfoItem(
              icon: Icons.air,
              value:
                  '${weather.windSpeed} ${units == 'metric' ? 'km/hr' : 'mph'}',
            ),
            _InfoItem(icon: Icons.water_drop, value: '${weather.humidity}%'),
            const _InfoItem(icon: Icons.wb_sunny, value: '8hr'),
          ],
        ),
      ],
    );
  }
}

/// ================= ICON =================
class _WeatherIcon extends StatelessWidget {
  final String description;

  const _WeatherIcon({required this.description});

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.cloud;

    final desc = description.toLowerCase();
    if (desc.contains('rain')) {
      icon = Icons.cloudy_snowing;
    } else if (desc.contains('cloud')) {
      icon = Icons.cloud;
    } else if (desc.contains('clear')) {
      icon = Icons.wb_sunny;
    }

    return Container(
      width: 160,
      height: 160,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFFFC371), Color(0xFFFF5F6D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(icon, size: 90, color: Colors.white),
    );
  }
}

/// ================= INFO ITEM =================
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String value;

  const _InfoItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
