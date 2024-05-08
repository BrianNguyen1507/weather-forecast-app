class WeatherImage {
  final int weatherCode;

  WeatherImage({
    required this.weatherCode,
  });

  String getImageUrl() {
    switch (weatherCode) {
      case 0:
        return 'assets/sun.png';
      case 1:
      case 2:
      case 3:
        return 'assets/lightcloud.png';
      case 45:
      case 48:
        return 'assets/fog.png';
      case 51:
      case 53:
      case 55:
        return 'assets/lightrain.png';
      case 56:
      case 57:
        return 'assets/lightrain.png';
      case 61:
      case 63:
      case 65:
        return 'assets/lightrain.png';
      case 66:
      case 67:
        return 'assets/lightrain.png';
      case 71:
      case 73:
      case 75:
        return 'assets/snow.png';
      case 77:
        return 'assets/snow.png';
      case 80:
      case 81:
      case 82:
        return 'assets/showers.png';
      case 85:
      case 86:
        return 'assets/snow.png.png';
      case 95:
      case 96:
      case 99:
        return 'assets/thunderstorm.png';
      default:
        return 'assets/lightcloud.png';
    }
  }
}
