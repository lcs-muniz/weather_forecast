// Implementação concreta do FACADE que compõe todas as ações
import 'package:weather_app/core/patterns/result.dart';
import 'package:weather_app/core/typesdef/types_defs.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/usecases/weather_usecases_contracts.dart';
import 'package:weather_app/domain/usecases/weather_usecases_facade_contract.dart';

class WeatherFacade implements IWeatherUseCasesFacade {
  final IGetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final IGetForecastUseCase _getForecastUseCase;
  final IGetWeatherByCoordinatesUseCase _getWeatherByCoordinatesUseCase;
  final IGetForecastByCoordinatesUseCase _getForecastByCoordinatesUseCase;
  final IGetCompleteWeatherUseCase _getCompleteWeatherUseCase;

  WeatherFacade({
    required IGetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required IGetForecastUseCase getForecastUseCase,
    required IGetWeatherByCoordinatesUseCase getWeatherByCoordinatesUseCase,
    required IGetForecastByCoordinatesUseCase getForecastByCoordinatesUseCase,
    required IGetCompleteWeatherUseCase getCompleteWeatherUseCase,
  }) : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
       _getForecastUseCase = getForecastUseCase,
       _getWeatherByCoordinatesUseCase = getWeatherByCoordinatesUseCase,
       _getForecastByCoordinatesUseCase = getForecastByCoordinatesUseCase,
       _getCompleteWeatherUseCase = getCompleteWeatherUseCase;

  @override
  Future<WeatherResult> getCurrentWeatherByCity(CityNameParams params) {
    return _getCurrentWeatherUseCase.call(params);
  }

  @override
  Future<WeatherResult> getCurrentWeatherByCoordinates(
    CoordinatesParams params,
  ) {
    return _getWeatherByCoordinatesUseCase.call(params);
  }

  @override
  Future<ForecastResult> getForecastByCity(CityNameParams params) {
    return _getForecastUseCase.call(params);
  }

  @override
  Future<ForecastResult> getForecastByCoordinates(CoordinatesParams params) {
    return _getForecastByCoordinatesUseCase.call(params);
  }
  @override
  Future<CompleteWeatherResult> getCompleteWeatherByCity(CityNameParams params) {
    return _getCompleteWeatherUseCase.call(params);
  }
  @override
  ForecastResult getMockForecast() {
    return Success(WeatherData.getForecast());
  }

  @override
  WeatherResult getMockWeather() {
    return Success(WeatherData.getCurrentWeather());
  }
  

}
