import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService();
  WeatherModel? _weather;
  
  _fetchWeather() async {
    final weather = await _weatherService.getWeather();
    setState(() {
      _weather = weather;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city...",
              style: const TextStyle(
                fontSize: 24.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
              image: AssetImage('assets/${_weather?.weatherIcon ?? "01d"}.png'),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.fill,
            ),
            Text(
              '${_weather?.temperature ?? '30'} °C',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]
        ),
      ),
    );
  }
}
