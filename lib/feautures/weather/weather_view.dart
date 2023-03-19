import 'package:example1/feautures/weather/weather_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherView extends HookConsumerWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(children: [
        currentWeather.when(
          data: (data) => Text(data),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text(error.toString()),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: City.values.length,
                itemBuilder: (context, index) {
                  final city = City.values[index];
                  final isSelected = city == ref.watch(currentCityProvide);
                  return ListTile(
                    title: Text(city.toString()),
                    trailing: isSelected ? const Icon(Icons.check) : null,
                    onTap: () =>
                        ref.read(currentCityProvide.notifier).state = city,
                  );
                }))
      ]),
    );
  }
}
