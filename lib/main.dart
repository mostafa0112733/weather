import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherdata();
  }

  Map<String, dynamic> weatherData = {};
  Future<void> _weatherdata() async {
    try {
      final apiurl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=cairo&appid=b95d6b1ca99d4300488617c73c02ed0d');
      final response = await http.get(apiurl);
      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
        });
      }
    } catch (e) {
      throw Exception('faild');
    }
  }
  double kelvinToCelsius(double tempInKelvin) {
    return tempInKelvin - 273.15; // Conversion from Kelvin to Celsius
  }
  @override
  Widget build(BuildContext context) {
     double temperatureInCelsius = weatherData.isNotEmpty
        ? kelvinToCelsius(weatherData['main']['temp'])
        : 0.0;
    return Scaffold(
      body: Center(
        child:  weatherData.isEmpty?
          CircularProgressIndicator()
          :
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [Text(
            'city: ${weatherData['name']}',
            style: TextStyle(fontSize: 24),
          ),
          Text('temparture: ${temperatureInCelsius.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 28),
          )
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: weather());
  }
}
