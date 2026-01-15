import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/weather_provider.dart';
import '../widgets/weather_card.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<WeatherProvider>();
      if (provider.lastLat != null && provider.lastLon != null) {
        provider.fetchWeather(provider.lastLat!, provider.lastLon!);
      } else {
        provider.refreshUsingDeviceLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final mq = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherNow'),
        actions: [
          // 🌡 Ganti unit suhu
          IconButton(
            icon: Icon(
              provider.units == 'metric' ? Icons.thermostat : Icons.ac_unit,
            ),
            onPressed: provider.toggleUnits,
          ),

          // 🌙☀️ Toggle Light / Dark Mode
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),

          // Refresh lokasi
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: provider.refreshUsingDeviceLocation,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.lightGradient,
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            if (provider.lastLat != null && provider.lastLon != null) {
              await provider.fetchWeather(provider.lastLat!, provider.lastLon!);
            } else {
              await provider.refreshUsingDeviceLocation();
            }
          },
          child: _buildContent(provider, mq),
        ),
      ),
    );
  }

  Widget _buildContent(WeatherProvider provider, MediaQueryData mq) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.weather == null) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: mq.size.height * 0.3),
          const Center(
            child: Text(
              'Tidak ada data cuaca.\nTarik untuk refresh.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    final w = provider.weather!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        WeatherCard(weather: w, units: provider.units),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detail Cuaca',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _infoRow('💧 Kelembapan', '${w.humidity}%'),
                const SizedBox(height: 8),
                _infoRow(
                  '💨 Angin',
                  '${w.windSpeed} '
                      '${provider.units == 'metric' ? 'm/s' : 'mph'}',
                ),
                const SizedBox(height: 8),
                _infoRow('📍 Lokasi', w.cityName),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
