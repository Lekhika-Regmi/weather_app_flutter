import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app_flutter/services/weather.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          print('location screen');
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }
  //147

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitDoubleBounce(color: Colors.white, size: 100)),
    );
  }
}
