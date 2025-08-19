// Interface do FACADE que compõe todas as ações de weather
import 'package:weather_app/core/typesdef/types_defs.dart';

abstract interface class IWeatherUseCasesFacade {
  // Ações básicas
  Future<WeatherResult> getCurrentWeatherByCity(CityNameParams params);
  Future<ForecastResult> getForecastByCity(CityNameParams params);
  Future<CompleteWeatherResult> getCompleteWeatherByCity(CityNameParams params);
  Future<WeatherResult> getCurrentWeatherByCoordinates(
    CoordinatesParams params,
  );
  Future<ForecastResult> getForecastByCoordinates(CoordinatesParams params);

  // Dados mock para fallback
  WeatherResult getMockWeather();
  ForecastResult getMockForecast();
}
