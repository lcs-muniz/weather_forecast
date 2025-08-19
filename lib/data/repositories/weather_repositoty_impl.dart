import 'package:weather_app/core/typesdef/types_defs.dart';
import 'package:weather_app/data/repositories/weather_repository_contract.dart';
import 'package:weather_app/data/services/weather_service_contract.dart';

class WeatherRepository implements IWeatherRepository {
  final IWeatherService _weatherService;

  WeatherRepository({required IWeatherService weatherService})
      : _weatherService = weatherService;

  @override
  Future<WeatherResult> getCurrentWeather(String cityName) {
    return _weatherService.getCurrentWeather(cityName);
  }

  @override
  Future<ForecastResult> getForecast(String cityName) {
    return _weatherService.getForecast(cityName);
  }

  @override
  Future<WeatherResult> getWeatherByCoordinates(double lat, double lon) {
    return _weatherService.getWeatherByCoordinates(lat, lon);
  }

  @override
  Future<ForecastResult> getForecastByCoordinates(double lat, double lon) {
    return _weatherService.getForecastByCoordinates(lat, lon);
  }
}
