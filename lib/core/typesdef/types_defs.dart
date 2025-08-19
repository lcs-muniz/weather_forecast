import 'package:flutter/foundation.dart';
import 'package:weather_app/core/errors/errors_classes.dart';
import 'package:weather_app/core/patterns/result.dart';
import 'package:weather_app/domain/models/weather.dart';

// typedefs para tipo Result
typedef WeatherResult = Result<Weather,Failure>;
typedef ForecastResult = Result<List<WeatherForecast>,Failure>;
typedef CompleteWeatherResult = Result<(Weather, List<WeatherForecast>),Failure>;

// typedfs para parâmetros
typedef CityNameParams = ({@required String cityName});
typedef CoordinatesParams = ({@required double lat, @required double lon});
