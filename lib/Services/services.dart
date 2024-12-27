import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/Model/weather_model.dart';

class WeatherServices {
  // Add a list of predefined locations
  static const Map<String, Map<String, double>> locations = {
    'Kathmandu': {'lat': 27.7172, 'lon': 85.3240},
    'Pokhara': {'lat': 28.2096, 'lon': 83.9856},
    'Biratnagar': {'lat': 26.4525, 'lon': 87.2718},
    // ... existing code ...
  };

  Future<WeatherData> fetchWeatherByCoords(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=4fb246bf8503a1dcf6633a4af25e0fb8",
        ),
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      rethrow;
    }
  }

  Future<WeatherData> fetchWeather(String locationName) async {
    final location = locations[locationName];
    if (location == null) {
      throw Exception('Location not found');
    }

    return fetchWeatherByCoords(location['lat']!, location['lon']!);
  }
}
// replace the api key with your api key thay openWeathemap provide you
// for your current location provide the longitude and latitude of your current location
