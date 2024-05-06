class ImageWeather {
  final String status;
  ImageWeather({
    required this.status,
  });

  String getImageUrl() {
    switch (status.toLowerCase()) {
      case 'cloudy':
        return 'assets/lightcloud.png';
      case 'clear':
        return 'assets/sun.png';
      case 'sunny':
        return 'assets/sun.png';
      case 'partly':
        return 'assets/heavycloud.png';
      case 'showers':
        return 'assets/lightrain.png';
      case 'thunderstorms':
        return 'assets/thunderstorm.png';
      case 'scattered showers':
        return 'assets/lightrain.png';
      case 'Partly Cloudy':
        return 'assets/lightcloud.png';
      default:
        return 'assets/lightcloud.png';
    }
  }
}
