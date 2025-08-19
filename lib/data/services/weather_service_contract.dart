import 'package:weather_app/core/typesdef/types_defs.dart';

// Interface para serviços de clima
abstract interface class IWeatherService {
  // Buscar clima atual por nome da cidade
  Future<WeatherResult> getCurrentWeather(String cityName);
  
  // Buscar previsão de 5 dias por nome da cidade
  Future<ForecastResult> getForecast(String cityName);
  
  // Buscar clima atual por coordenadas
  Future<WeatherResult> getWeatherByCoordinates(double lat, double lon);
  
  // Buscar previsão por coordenadas
  Future<ForecastResult> getForecastByCoordinates(double lat, double lon);
}
