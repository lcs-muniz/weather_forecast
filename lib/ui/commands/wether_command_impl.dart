// Comando para buscar clima atual por cidade
import 'package:weather_app/core/errors/errors_classes.dart';
import 'package:weather_app/core/patterns/command.dart';
import 'package:weather_app/core/patterns/result.dart';
import 'package:weather_app/core/typesdef/types_defs.dart';
import 'package:weather_app/domain/models/weather.dart';
import 'package:weather_app/domain/usecases/weather_usecases_facade_contract.dart';

final class GetWeatherByCityCommand
    extends ParameterizedCommand<Weather, Failure, CityNameParams> {
  final IWeatherUseCasesFacade _weatherFacade;

  GetWeatherByCityCommand(this._weatherFacade);

  @override
  Future<WeatherResult> execute() async {
    // TODO: apagar depois de testar
    // Simula um atraso para demonstr
    await Future.delayed(const Duration(seconds: 2));
    if (parameter == null || parameter!.cityName.isEmpty) {
      return Error(EmptyField('Nomre da cidade não pode ser vazio'));
    }

    return await _weatherFacade.getCurrentWeatherByCity(parameter!);
  }
}

final class GetForecastByCityCommand
    extends
        ParameterizedCommand<List<WeatherForecast>, Failure, CityNameParams> {
  final IWeatherUseCasesFacade _weatherFacade;

  GetForecastByCityCommand(this._weatherFacade);

  @override
  Future<ForecastResult> execute() async {
    // TODO: apagar depois de testar
    // Simula um atraso para demonstr
    await Future.delayed(const Duration(seconds: 2));
    if (parameter == null || parameter!.cityName.isEmpty) {
      return Error(EmptyField('Nome da cidade não pode ser vazio'));
    }

    return await _weatherFacade.getForecastByCity(parameter!);
  }
}

final class GetCompleteWeatherCommand
    extends
        ParameterizedCommand<
          (Weather, List<WeatherForecast>),
          Failure,
          CityNameParams
        > {
  final IWeatherUseCasesFacade _weatherFacade;

  GetCompleteWeatherCommand(this._weatherFacade);

  @override
  Future<CompleteWeatherResult> execute() async {
    // TODO: apagar depois de testar
    // Simula um atraso para demonstr
    await Future.delayed( const Duration(seconds: 2));
    if (parameter == null || parameter!.cityName.isEmpty) {
      return Error(EmptyField('Nome da cidade não pode ser vazio'));
    }

    return await _weatherFacade.getCompleteWeatherByCity(parameter!);
  }
}

final class GetWeatherByCoordinatesCommand
    extends ParameterizedCommand<Weather, Failure, CoordinatesParams> {
  final IWeatherUseCasesFacade _weatherFacade;

  GetWeatherByCoordinatesCommand(this._weatherFacade);

  @override
  Future<WeatherResult> execute() async {
    if (parameter == null) {
      return Error(EmptyField('Coordenadas não podem ser nulas'));
    }
    return await _weatherFacade.getCurrentWeatherByCoordinates(parameter!);
  }
}

final class GetForecastByCoordinatesCommand
    extends
        ParameterizedCommand<
          List<WeatherForecast>,
          Failure,
          CoordinatesParams
        > {
  final IWeatherUseCasesFacade _weatherFacade;

  GetForecastByCoordinatesCommand(this._weatherFacade);

  @override
  Future<ForecastResult> execute() async {
    if (parameter == null) {
      return Error(EmptyField('Coordenadas não podem ser nulas'));
    }

    return await _weatherFacade.getForecastByCoordinates(parameter!);
  }
}
