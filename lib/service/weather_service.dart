import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import '../model/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fail to load weather data');
    }
  }


  // get location permision
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    // get permission from user
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    // convert the location in to list of place mark objects
    List<Placemark> placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first place mark
    String? city = placemark[0].locality;

    return city ?? '';
  }


}

