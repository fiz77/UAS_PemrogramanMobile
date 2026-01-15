import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'di/service_locator.dart';
import 'providers/weather_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/name_provider.dart';

import 'ui/screens/home_screen.dart';
import 'ui/theme/app_theme.dart';

import 'pages/todo_page.dart';
import 'pages/provider_page.dart';
import 'pages/getx_page.dart';
import 'pages/login_page.dart';
import 'pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<WeatherProvider>()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NameProvider()),
      ],
      child: const SplashWrapper(),
    ),
  );
}

class SplashWrapper extends StatelessWidget {
  const SplashWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ToDoPage(),
    ProviderPage(),
    GetXPage(),
    LoginPage(),
    HomeScreen(), // Weather page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return GetMaterialApp(
          title: 'Flutter State Management + Weather',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.list_alt),
                  label: 'To-Do',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_alt),
                  label: 'Provider',
                ),
                NavigationDestination(icon: Icon(Icons.bolt), label: 'GetX'),
                NavigationDestination(icon: Icon(Icons.login), label: 'Login'),
                NavigationDestination(
                  icon: Icon(Icons.cloud),
                  label: 'Weather',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
