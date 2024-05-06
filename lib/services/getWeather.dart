import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Constant/privatekey.dart';

class GetData {
  final String location;
  final String value;
  GetData({
    required this.location,
    required this.value,
  });
  Future<Map<String, dynamic>> fetchingData() async {
    try {
      final url = Uri.parse(
          'https://yahoo-weather5.p.rapidapi.com/weather?location=$location&format=json&u=$value');
      final response = await http.get(
        url,
        headers: {
          "x-rapidapi-key": Apiheader.key,
          "x-rapidapi-host": Apiheader.host,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
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
