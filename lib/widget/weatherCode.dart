class WeatherDescription {
  final int weatherCode;

  WeatherDescription({
    required this.weatherCode,
  });
  String getWeatherDescription() {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Clear \n Partly Cloudy , Overcast';
      case 45:
      case 48:
        return 'Fog and rime fog';
      case 51:
      case 53:
      case 55:
        return 'Drizzle \n Light, moderate, dense intensity';
      case 56:
      case 57:
        return 'Freezing Drizzle \n Light, dense intensity';
      case 61:
      case 63:
      case 65:
        return 'Rain\n Slight, moderate, heavy intensity';
      case 66:
      case 67:
        return 'Freezing Rain \n Light, heavy intensity';
      case 71:
      case 73:
      case 75:
        return 'Snow fall\n Slight, moderate, heavy intensity';
      case 77:
        return 'Snow grains';
      case 80:
      case 81:
      case 82:
        return 'Rain showers\n Slight, moderate, violent';
      case 85:
      case 86:
        return 'Snow showers\n Light, heavy';
      case 95:
        return 'Thunderstorm\n Slight, moderate';
      case 96:
      case 99:
        return 'Thunderstorm with hail \n Slight, heavy';
      default:
        return 'Unknown';
    }
  }
}
