import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService('b6ca587de9ace9b4d8278eea6cd927d4');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get the current city
    String cityName = await _weatherService.getCurrentCity();
    
    //get weather for city
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState((){
        _weather = weather;
      });
    }

    //any errors
    catch (e) {
      log("Received Error:{$e}");
    }
  }


  //weather animations

  //init state
  @override
  void initState(){
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cityname
            Text(_weather?.cityName ?? "loading city.."),
        
            //temperature
            Text("${_weather?.temperature.round()}ºC")            
          ],
        ),
      )
    );
  }
}