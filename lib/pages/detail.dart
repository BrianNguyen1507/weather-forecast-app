import 'package:flutter/material.dart';
import 'package:weather_app/widget/getDateTime.dart';
import 'package:weather_app/widget/weatherCode.dart';
import 'package:weather_app/widget/weatherUrl.dart';

class WeatherDetailPage extends StatelessWidget {
  final String date;
  final double highTemperatureCelsius;
  final double lowTemperatureCelsius;
  final String image;
  final int code;

  const WeatherDetailPage({
    super.key,
    required this.date,
    required this.highTemperatureCelsius,
    required this.lowTemperatureCelsius,
    required this.image,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    GetDateTime getdate = GetDateTime();
    WeatherDescription weatherDescription =
        WeatherDescription(weatherCode: code);
    WeatherImage image = WeatherImage(weatherCode: code);
    String imageUrl = image.getImageUrl();
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Detail Weather',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 100,
                child: Image.asset(imageUrl),
              ),
            ),
            Text(
              'Date: ${getdate.convertToMonthName(date)} ',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildTemperatureRow(
              'High Temperature',
              '$highTemperatureCelsius°C',
              Icons.arrow_upward,
            ),
            const SizedBox(height: 10),
            _buildTemperatureRow(
              'Low Temperature',
              '$lowTemperatureCelsius°C',
              Icons.arrow_downward,
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather Description',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            _buildWeatherDescription(
                weatherDescription.getWeatherDescription()),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureRow(String title, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildWeatherDescription(String description) {
    return Text(
      description,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    );
  }
}