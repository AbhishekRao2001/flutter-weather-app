import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text;
                if (city.isNotEmpty) {
                  context.read<WeatherProvider>().fetchWeather(city);
                }
              },
              child: const Text('Get Weather'),
            ),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.loading) {
                  return const CircularProgressIndicator();
                }
                if (provider.weather != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushNamed(context, '/weather');
                  });
                }
                if (provider.error != null) {
                  return Text(provider.error!);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
