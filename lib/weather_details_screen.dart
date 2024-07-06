import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherProvider>().weather;

    return Scaffold(
      appBar: AppBar(title: const Text('Weather Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: weather == null
            ? const Center(child: Text('No data available'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('City: ${weather.cityName}',
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      'Temperature: ${weather.temperature.toStringAsFixed(1)} °C',
                      style: const TextStyle(fontSize: 20)),
                  Text('Condition: ${weather.condition}',
                      style: const TextStyle(fontSize: 20)),
                  Flexible(child: Image.network(weather.iconUrl)),
                  Text('Humidity: ${weather.humidity}%',
                      style: const TextStyle(fontSize: 20)),
                  Text(
                      'Wind Speed: ${weather.windSpeed.toStringAsFixed(1)} m/s',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherProvider>().refreshWeather();
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
      ),
    );
  }
}
