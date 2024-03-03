import 'dart:convert';

// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';

  WeatherService();

  Future<WeatherModel> getWeather() async {
    _checkAndRequestPermission();

    // final position = await Geolocator.getCurrentPosition();
    // final responseBody = await getDataFromAPI(position.latitude, position.longitude);
    final responseBody = await getDataFromAPI(1.2942, 103.7861);

    return WeatherModel.fromJson(responseBody);
  }

  Future<void> _checkAndRequestPermission() async {
    return;
    // final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // } else if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //     'Location permissions are permanently denied, we cannot request permissions.');
    // } 
  }

  Future<Map<String, dynamic>> getDataFromAPI(double latitude, double longitude) async {
    final apiKey = dotenv.env['API_KEY'];
    final url = Uri.parse('$BASE_URL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Future.error('Failed to load weather');
    }
    return jsonDecode(response.body);
  }
}