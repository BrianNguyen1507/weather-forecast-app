import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/constant/privatekey.dart';

class Geoapify {
  final String location;
  Geoapify({
    required this.location,
  });
  Future<Map<String, dynamic>> fetchingLocation() async {
    try {
      final url = Uri.parse(
          'https://api.geoapify.com/v1/geocode/search?text=$location&apiKey=${KEY.geoapifyKey}');
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
