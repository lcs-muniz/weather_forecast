// Configurações da API
class ApiConfig {
  // OpenWeatherMap API
  static const String openWeatherMapBaseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String openWeatherMapApiKey = 'YOUR_API_KEY_HERE'; // Substitua pela sua chave
  
  // URLs de endpoints
  static const String currentWeatherEndpoint = '/weather';
  static const String forecastEndpoint = '/forecast';
  
  // Parâmetros padrão
  static const String units = 'metric'; // Celsius
  static const String language = 'pt_br'; // Português brasileiro
  
  // Timeouts
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 15);
  
  // Alternativas de API (caso queira usar outras)
  // WeatherAPI
  static const String weatherApiBaseUrl = 'https://api.weatherapi.com/v1';
  static const String weatherApiKey = 'YOUR_WEATHER_API_KEY_HERE';
  
  // AccuWeather
  static const String accuWeatherBaseUrl = 'https://dataservice.accuweather.com';
  static const String accuWeatherApiKey = 'YOUR_ACCUWEATHER_API_KEY_HERE';
  
  // Métodos auxiliares
  static String buildCurrentWeatherUrl(String cityName) {
    return '$openWeatherMapBaseUrl$currentWeatherEndpoint'
           '?q=$cityName'
           '&appid=$openWeatherMapApiKey'
           '&units=$units'
           '&lang=$language';
  }
  
  static String buildForecastUrl(String cityName) {
    return '$openWeatherMapBaseUrl$forecastEndpoint'
           '?q=$cityName'
           '&appid=$openWeatherMapApiKey'
           '&units=$units'
           '&lang=$language';
  }
  
  static String buildCurrentWeatherByCoordinatesUrl(double lat, double lon) {
    return '$openWeatherMapBaseUrl$currentWeatherEndpoint'
           '?lat=$lat'
           '&lon=$lon'
           '&appid=$openWeatherMapApiKey'
           '&units=$units'
           '&lang=$language';
  }
  
  static String buildForecastByCoordinatesUrl(double lat, double lon) {
    return '$openWeatherMapBaseUrl$forecastEndpoint'
           '?lat=$lat'
           '&lon=$lon'
           '&appid=$openWeatherMapApiKey'
           '&units=$units'
           '&lang=$language';
  }
}