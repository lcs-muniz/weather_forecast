// UseCase para buscar clima atual por cidade
import 'package:weather_app/core/errors/errors_classes.dart';
import 'package:weather_app/core/patterns/result.dart';
import 'package:weather_app/core/typesdef/types_defs.dart';
import 'package:weather_app/data/repositories/weather_repository_contract.dart';
import 'package:weather_app/domain/usecases/weather_usecases_contracts.dart';

class GetCurrentWeatherUseCase implements IGetCurrentWeatherUseCase {
  final IWeatherRepository _repository;

  GetCurrentWeatherUseCase({required IWeatherRepository repository})
    : _repository = repository;

  @override
  Future<WeatherResult> call(CityNameParams params) async {
    return _repository.getCurrentWeather(params.cityName);
  }
}

class GetForecastUseCase implements IGetForecastUseCase {
  final IWeatherRepository _repository;

  GetForecastUseCase({required IWeatherRepository repository})
    : _repository = repository;

  @override
  Future<ForecastResult> call(CityNameParams params) async {
    return _repository.getForecast(params.cityName);
  }
}

class GetWeatherByCoordinatesUseCase
    implements IGetWeatherByCoordinatesUseCase {
  final IWeatherRepository _repository;

  GetWeatherByCoordinatesUseCase({required IWeatherRepository repository})
    : _repository = repository;

  @override
  Future<WeatherResult> call(CoordinatesParams params) async {
    return _repository.getWeatherByCoordinates(params.lat, params.lon);
  }
}

class GetForecastByCoordinatesUseCase
    implements IGetForecastByCoordinatesUseCase {
  final IWeatherRepository _repository;

  GetForecastByCoordinatesUseCase({required IWeatherRepository repository})
    : _repository = repository;

  @override
  Future<ForecastResult> call(CoordinatesParams params) async {
    return _repository.getForecastByCoordinates(params.lat, params.lon);
  }
}

class GetCompleteWeatherUseCase implements IGetCompleteWeatherUseCase {
  final IGetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final IGetForecastUseCase _getForecastUseCase;

  GetCompleteWeatherUseCase({
    required IGetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required IGetForecastUseCase getForecastUseCase,
  }) : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
       _getForecastUseCase = getForecastUseCase;

  @override
  Future<CompleteWeatherResult> call(CityNameParams params) async {
    final weatherFuture = _getCurrentWeatherUseCase(params);
    final forecastFuture = _getForecastUseCase(params);

    // executa em paralelo
    final (weatherResult, forecastResult) =
        await (weatherFuture, forecastFuture).wait;

    // final weatherResult = results[0] as Result<Weather, Failure>;
    // final forecastResult = results[1] as Result<List<WeatherForecast>, Failure>;

    // se algum falhou, propaga o erro direto
    if (weatherResult.isFailure) {
      return Error(weatherResult.failureValueOrNull as Failure);
    }
    if (forecastResult.isFailure) {
      return Error(forecastResult.failureValueOrNull as Failure);
    }

    // se chegou até aqui, os dois deram certo
    return Success((
      weatherResult.successValueOrNull!,
      forecastResult.successValueOrNull!,
    ));
  }
}
