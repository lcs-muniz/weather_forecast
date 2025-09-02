import 'dart:async';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:weather_app/core/dependencies/injection_dependencies.dart';
import 'package:weather_app/ui/controllers/home_weather_view_model.dart';
import 'package:weather_app/ui/widgets/current_weather_card.dart';
import 'package:weather_app/ui/widgets/error_container.dart';
import 'package:weather_app/ui/widgets/forecast_list.dart';
import 'package:weather_app/ui/widgets/weather_detail_card.dart';
import 'package:weather_app/ui/widgets/weather_search_bar.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key, required this.title});

  final String title;
  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late WeatherHomeViewController _viewController;
  // Controller para campo de busca
  final searchController = TextEditingController();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _viewController = injector.get<WeatherHomeViewController>();
    _startAutoRefreshTimer();
  }

  @override
  void dispose() {
    searchController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefreshTimer() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_viewController.currentWeather.value != null) {
        _viewController.searchWeatherByCity(
          _viewController.currentWeather.value!.cityName,
        );
      }
    });
  }

  Future<void> _handleRefresh() async {
    if (_viewController.currentWeather.value != null) {
      await _viewController.searchWeatherByCity(
        _viewController.currentWeather.value!.cityName,
      );
    }
  }

  void _onSearch(String cityName) async {
    cityName = searchController.text.trim();
    if (cityName.isNotEmpty) {
      // Mostrar indicador de busca
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Buscando dados para "$cityName"...'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );

      await _viewController.searchWeatherByCity(cityName);
      searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.1),
        title: Text(widget.title),
      ),
      body: SafeArea(
        // use refresh indicator para permitir que o usuário atualize os dados puxando para baixo
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WeatherSearchBar(
                  controller: searchController,
                  onSearch: _onSearch,
                  isLoading: _viewController.isLoadingWeather,
                ),
                Watch(
                  (_) => _viewController.errorMessage.value != null
                      ? ErrorContainer(
                          onRetry: _handleRefresh,
                          errorMessage: _viewController.errorMessage.value!,
                        )
                      : const SizedBox.shrink(),
                ),
                //CurrentWeatherCard(weather: WeatherData.getCurrentWeather()),
                // Clima atual
                Watch(
                  (_) => _viewController.currentWeather.value != null
                      ? CurrentWeatherCard(
                          weather: _viewController.currentWeather.value!,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                // WeatherDetailsCard(weather: WeatherData.getCurrentWeather()),
                // Detalhes do clima
                Watch(
                  (_) => _viewController.currentWeather.value != null
                      ? WeatherDetailsCard(
                          weather: _viewController.currentWeather.value!,
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 16),
                // ForecastList(forecasts: WeatherData.getForecast()),
                // Lista de previsão
                Watch(
                  (_) => _viewController.forecast.value.isNotEmpty
                      ? ForecastList(
                          forecasts: _viewController.forecast.value,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
