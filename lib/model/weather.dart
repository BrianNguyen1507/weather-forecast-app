class WeatherData {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final CurrentUnits currentUnits;
  final Current current;
  final DailyUnits dailyUnits;
  final Daily daily;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentUnits: CurrentUnits.fromJson(json['current_units']),
      current: Current.fromJson(json['current']),
      dailyUnits: DailyUnits.fromJson(json['daily_units']),
      daily: Daily.fromJson(json['daily']),
    );
  }
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String apparentTemperature;
  final String isDay;
  final String weatherCode;
  final String windSpeed10m;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.isDay,
    required this.weatherCode,
    required this.windSpeed10m,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) {
    return CurrentUnits(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      isDay: json['is_day'],
      weatherCode: json['weather_code'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class Current {
  final String time;
  final int interval;
  final double temperature2m;
  final int relativeHumidity2m;
  final double apparentTemperature;
  final int isDay;
  final int weatherCode;
  final double windSpeed10m;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.apparentTemperature,
    required this.isDay,
    required this.weatherCode,
    required this.windSpeed10m,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      time: json['time'],
      interval: json['interval'],
      temperature2m: json['temperature_2m'],
      relativeHumidity2m: json['relative_humidity_2m'],
      apparentTemperature: json['apparent_temperature'],
      isDay: json['is_day'],
      weatherCode: json['weather_code'],
      windSpeed10m: json['wind_speed_10m'],
    );
  }
}

class DailyUnits {
  final String time;
  final String weatherCode;
  final String temperature2mMax;
  final String temperature2mMin;

  DailyUnits({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) {
    return DailyUnits(
      time: json['time'],
      weatherCode: json['weather_code'],
      temperature2mMax: json['temperature_2m_max'],
      temperature2mMin: json['temperature_2m_min'],
    );
  }
}

class Daily {
  final List<String> time;
  final List<int> weatherCode;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;

  Daily({
    required this.time,
    required this.weatherCode,
    required this.temperature2mMax,
    required this.temperature2mMin,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      time: List<String>.from(json['time']),
      weatherCode: List<int>.from(json['weather_code']),
      temperature2mMax: List<double>.from(json['temperature_2m_max']),
      temperature2mMin: List<double>.from(json['temperature_2m_min']),
    );
  }
}
