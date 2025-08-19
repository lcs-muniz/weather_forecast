import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class WeatherSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSearch;
  final ReadonlySignal<bool> isLoading;

  const WeatherSearchBar({
    super.key,
    required this.controller,
    required this.isLoading,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Digite o nome da cidade",
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: Watch(
            (_) =>
                isLoading.value
                    ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                    : IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus(); // fecha teclado
                        onSearch?.call(
                          controller.text,
                        ); 
                      },
                    ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        style: Theme.of(context).textTheme.bodyLarge,
        onSubmitted: (value) {
          FocusScope.of(context).unfocus();
          onSearch?.call(value);
        },
      ),
    );
  }
}
