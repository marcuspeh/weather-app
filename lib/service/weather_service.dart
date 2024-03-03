import 'dart:convert';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';

  Location location = Location();

  WeatherService();

  Future<WeatherModel> getWeather() async {
    _checkAndRequestPermission();

    final locationData = await location.getLocation();
    final responseBody = await getDataFromAPI(locationData.latitude ?? 0, locationData.longitude ?? 0);
    
    return WeatherModel.fromJson(responseBody);
  }

  Future<void> _checkAndRequestPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    } else if (permissionGranted == PermissionStatus.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 
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