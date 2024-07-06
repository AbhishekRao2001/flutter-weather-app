import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String icon;



  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15,
      condition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      icon: json['weather'][0]['icon'],
    );
  }
  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}

class WeatherProvider extends ChangeNotifier {
  Weather? weather;
  bool loading = false;
  String? error;
  String? lastSearchedCity;

  Future<void> fetchWeather(String city) async {
    loading = true;
    error = null;
    notifyListeners();

    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=f0f91c5fcef25a26055c011596d21385';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        weather = Weather.fromJson(json.decode(response.body));
        lastSearchedCity = city;
        await _saveLastSearchedCity(city);
      } else {
        error = 'Error: ${response.reasonPhrase}';
      }
    } catch (e) {
      error = 'Failed to fetch weather data';
    }

    loading = false;
    notifyListeners();
  }

  Future<void> refreshWeather() async {
    if (lastSearchedCity != null) {
      await fetchWeather(lastSearchedCity!);
    }
  }

  Future<void> _saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastSearchedCity', city);
  }

  Future<void> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    lastSearchedCity = prefs.getString('lastSearchedCity');
    if (lastSearchedCity != null) {
      await fetchWeather(lastSearchedCity!);
    }
  }
}
