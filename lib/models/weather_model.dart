class WeatherModel {
  final String cityName;
  final double temperature;
  final String weatherName;
  final String weatherDescription;
  final String weatherIcon;

  WeatherModel({
    required this.cityName, 
    required this.temperature, 
    required this.weatherName,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'],
      weatherName: json['weather'][0]['main'],
      weatherDescription: json['weather'][0]['description'],
      weatherIcon: json['weather'][0]['icon'],
    );
  }
}
