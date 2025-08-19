// Interface base para UseCase
import 'package:weather_app/core/typesdef/types_defs.dart';

abstract interface class IUseCase<T, Params extends Object?> {
  Future<T> call(Params params);
}

abstract interface class IGetCurrentWeatherUseCase
    implements IUseCase<WeatherResult, CityNameParams> {}

abstract interface class IGetForecastUseCase
    implements IUseCase<ForecastResult, CityNameParams> {}

abstract interface class IGetWeatherByCoordinatesUseCase
    implements IUseCase<WeatherResult, CoordinatesParams> {}

abstract interface class IGetForecastByCoordinatesUseCase
    implements IUseCase<ForecastResult, CoordinatesParams> {}

abstract interface class IGetCompleteWeatherUseCase
    implements IUseCase<CompleteWeatherResult, CityNameParams> {}
