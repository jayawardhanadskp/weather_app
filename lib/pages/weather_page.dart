import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../model/weather_model.dart';
import '../service/weather_service.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key
  final _weatherService = WeatherService('531a7d38bf6ff4819ddd8f9107d3f0bc');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // weather animation
  LottieBuilder getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return Lottie.network('https://lottie.host/a805ea1f-cf98-44fb-a6ad-1e6aa48e4cfc/IuZ9GSG94g.json'); // default sunney

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'frog':
        return Lottie.network('https://lottie.host/720c7f7e-b240-4a07-b879-1efacdf38e41/8m91yBqn7f.json');

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return LottieBuilder.network('https://lottie.host/34734f7e-54a8-4b5e-8ce8-b9c375f676ce/1o7pMChXX9.json');

      case 'thunderstorm':
        return Lottie.network('https://lottie.host/5093ce74-ecd1-44ac-9e4f-5c5345f4a692/0hMPBNHq7j.json');

      case 'clear':
        return Lottie.network('https://lottie.host/a805ea1f-cf98-44fb-a6ad-1e6aa48e4cfc/IuZ9GSG94g.json');

      default:
        return Lottie.network('https://lottie.host/a805ea1f-cf98-44fb-a6ad-1e6aa48e4cfc/IuZ9GSG94g.json');

    }
  }

  @override
  void initState() {
    // fetch weather on startup
    _fetchWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // city name
            Column(
              children: [
                Icon(Icons.location_on, size: 30,),
                SizedBox(height: 10,),
                Text(_weather?.cityName ?? 'Loading city..',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),

            // animation
            getWeatherAnimation(_weather?.mainConditions),

            Column(
              children: [
                // temperature
                Text('${_weather?.temparatuer.round()} °C',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                  ),
                ),

                // weather condition
                Text(_weather?.mainConditions ?? '',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
