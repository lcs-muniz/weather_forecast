import 'package:flutter/material.dart';
import 'package:weather_app/core/dependencies/injection_dependencies.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/ui/views/weather_home_page.dart';

void main() {
  setupDependencyInjection();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Previsão do Tempo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const WeatherHomePage(title: 'Aula Nova Saindo do Forno'),
    ),
  );
}
