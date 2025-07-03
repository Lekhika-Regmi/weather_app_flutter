import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

void getLocation() async {
  Location location = Location();
  await location.getCurrentLocation();
  print(location.latitude);
  print(location.longitude);
}

void getData() async {
  Response response = await get(
    Uri.parse(
      'https://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=5&appid=b1b15e88fa797225412429c1c50c122a1',
    ),
  );
  if (response.statusCode == 200) {
    String data = response.body;
    //decoding into a list
    final List<dynamic> results = jsonDecode(data);
    if (results.isEmpty) {
      print('No locations found');
      return;
    }
    for (var item in results) {
      final map = item as Map<String, dynamic>;
      print(map['local_names']['ru']); // London, then Londonderry
    }
  } else {
    print(response.statusCode);
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }
  //147

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
