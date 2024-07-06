import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/weather_details_screen.dart';
import 'package:weather_app/weather_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider()..loadLastSearchedCity(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/weather': (context) => WeatherDetailsScreen(),
      },
    );
  }
}
