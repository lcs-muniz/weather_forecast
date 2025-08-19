import 'package:flutter/material.dart';
import 'package:weather_app/domain/models/weather.dart';

class ForecastList extends StatelessWidget {
  final List<WeatherForecast> forecasts;

  const ForecastList({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Previsão dos próximos 5 dias",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children:
                forecasts
                    .map((forecast) => _buildForecastItem(context, forecast))
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildForecastItem(BuildContext context, WeatherForecast forecast) {
    final isLast = forecasts.indexOf(forecast) == forecasts.length - 1;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border:
            isLast
                ? null
                : Border(
                  bottom: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              forecast.dayOfWeek,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            forecast.icon,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              forecast.condition,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            "${forecast.minTemp.toInt()}°",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "${forecast.maxTemp.toInt()}°",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
