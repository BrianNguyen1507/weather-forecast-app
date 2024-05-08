import 'dart:convert';
import 'package:http/http.dart' as http;

class Forecastweather {
  final String lat;
  final String lon;
  Forecastweather({
    required this.lat,
    required this.lon,
  });
  Future<Map<String, dynamic>> fetchingWeather() async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/meteofrance?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min');
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Data: $responseData');
        return responseData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching: $e');
      return {};
    }
  }
}
