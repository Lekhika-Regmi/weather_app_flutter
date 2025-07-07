import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'location.dart';
import 'networking.dart';

class WeatherModel {
  String apikey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';

  Future<dynamic> getCityWeather(String cityName) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather(BuildContext context) async {
    Location location = Location();
    bool hasPermission = await location.getCurrentLocation(
      context,
    ); // Pass it here

    if (!hasPermission) {
      return null;
    }

    String latitude = location.latitude.toString();
    String longitude = location.longitude.toString();

    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric',
    );

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  // Return an emoji icon based on weather condition code
  String getWeatherIcon(int? condition) {
    if (condition == null) return '❓';
    if (condition < 300) return '🌩';
    if (condition < 400) return '🌧';
    if (condition < 600) return '☔️';
    if (condition < 700) return '☃️';
    if (condition < 800) return '🌫';
    if (condition == 800) return '☀️';
    if (condition <= 804) return '☁️';
    return '🤷‍♂️'; // fallback
  }

  // Return a message based on temperature
  String getMessage(int temp) {
    if (temp > 25) return 'It\'s 🍦 time';
    if (temp > 20) return 'Time for shorts and 👕';
    if (temp < 10) return 'You\'ll need 🧣 and 🧤';
    return 'Bring a 🧥 just in case';
  }
}
