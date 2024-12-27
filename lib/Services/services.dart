import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/Model/weather_model.dart';

class WeatherServices {
  fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=28.5175&lon=81.7787&appid=4fb246bf8503a1dcf6633a4af25e0fb8"),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      rethrow; // This will allow the calling code to handle the error
    }
  }
}
// replace the api key with your api key thay openWeathemap provide you
// for your current location provide the longitude and latitude of your current location
