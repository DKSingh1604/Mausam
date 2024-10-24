import 'package:flutter/material.dart';
import 'package:mausam/models/weather_model.dart';
import 'package:mausam/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  final _weatherService = WeatherService('f8dda0e84891cdc0f8ee1d0f82c072cb');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();
    print("City name: $cityName");
    if (cityName == 'Unknown') {
      print("Could not determine the city.");
      return;
    }

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any errors
    catch (e) {
      print(e);
    }
  }

  //weather animations

  //init state
  @override
  void initState() {
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
            //city name
            Text(_weather?.cityName ?? "loading city..."),

            //temperature
            Text('${_weather?.temperature.round().toString()}0C'),
          ],
        ),
      ),
    );
  }
}
