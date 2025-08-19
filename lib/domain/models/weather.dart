import 'package:flutter/material.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final IconData icon;
  final String description;
  final double humidity;
  final double windSpeed;
  final double pressure;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.description,
    this.humidity = 0,
    this.windSpeed = 0,
    this.pressure = 0,
  });

  // Factory constructor para criar Weather a partir de JSON da API
  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    final wind = json['wind'] ?? {};
    
    return Weather(
      cityName: json['name'],
      temperature: (main['temp'] as num).toDouble(),
      condition: _translateCondition(weather['main']),
      icon: _getIconFromCondition(weather['main']),
      description: weather['description'],
      humidity: (main['humidity'] as num).toDouble(),
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0,
      pressure: (main['pressure'] as num).toDouble(),
    );
  }

  static String _translateCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'Ensolarado';
      case 'clouds':
        return 'Nublado';
      case 'rain':
        return 'Chuva';
      case 'drizzle':
        return 'Garoa';
      case 'thunderstorm':
        return 'Tempestade';
      case 'snow':
        return 'Neve';
      case 'mist':
      case 'fog':
        return 'Neblina';
      default:
        return condition;
    }
  }

  static IconData _getIconFromCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.wb_cloudy;
      case 'rain':
        return Icons.grain;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.foggy;
      default:
        return Icons.wb_sunny;
    }
  }
}

class WeatherForecast {
  final String dayOfWeek;
  final IconData icon;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final DateTime date;

  const WeatherForecast({
    required this.dayOfWeek,
    required this.icon,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.date,
  });

  // Factory constructor para criar WeatherForecast a partir de JSON da API
  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final main = json['main'];
    final weather = json['weather'][0];
    final dateTime = DateTime.parse(json['dt_txt']);
    
    return WeatherForecast(
      dayOfWeek: _formatDayOfWeek(dateTime),
      icon: Weather._getIconFromCondition(weather['main']),
      maxTemp: (main['temp_max'] as num).toDouble(),
      minTemp: (main['temp_min'] as num).toDouble(),
      condition: Weather._translateCondition(weather['main']),
      date: dateTime,
    );
  }

  set city(city) {}

  static String _formatDayOfWeek(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);
    
    final difference = targetDate.difference(today).inDays;
    
    if (difference == 0) return 'Hoje';
    if (difference == 1) return 'Amanhã';
    
    const weekdays = [
      'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado', 'Domingo'
    ];
    
    return weekdays[date.weekday - 1];
  }
}

class WeatherData {
  // Dados mock para fallback quando a API não estiver disponível
  static Weather getCurrentWeather() => const Weather(
    cityName: "São Paulo",
    temperature: 23,
    condition: "Ensolarado",
    icon: Icons.wb_sunny,
    description: "Céu limpo com sol",
    humidity: 65,
    windSpeed: 15,
    pressure: 1013,
  );

  static List<WeatherForecast> getForecast() => [
    WeatherForecast(
      dayOfWeek: "Hoje",
      icon: Icons.wb_sunny,
      maxTemp: 26,
      minTemp: 18,
      condition: "Ensolarado",
      date: DateTime.now(),
    ),
    WeatherForecast(
      dayOfWeek: "Amanhã",
      icon: Icons.cloud,
      maxTemp: 22,
      minTemp: 15,
      condition: "Nublado",
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    WeatherForecast(
      dayOfWeek: "Quarta",
      icon: Icons.grain,
      maxTemp: 19,
      minTemp: 12,
      condition: "Chuva",
      date: DateTime.now().add(const Duration(days: 2)),
    ),
    WeatherForecast(
      dayOfWeek: "Quinta",
      icon: Icons.wb_cloudy,
      maxTemp: 24,
      minTemp: 16,
      condition: "Parcialmente nublado",
      date: DateTime.now().add(const Duration(days: 3)),
    ),
    WeatherForecast(
      dayOfWeek: "Sexta",
      icon: Icons.wb_sunny,
      maxTemp: 28,
      minTemp: 20,
      condition: "Ensolarado",
      date: DateTime.now().add(const Duration(days: 4)),
    ),
  ];
}