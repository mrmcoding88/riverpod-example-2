import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  berlin,
  barcelona,
  tehran,
}

typedef WeatherEmoji = String;
const unknownWeatherEmoji = '🤷🏼‍♂️';

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () => {
            City.barcelona: '☀️',
            City.berlin: '🌦️',
            City.tehran: '🌞',
          }[city]!);
}

/// [StateProvider] for getting the current selected city
final currentCityProvide = StateProvider<City?>(
  (ref) => null,
);

/// [FutureProvider] of the weather. Dependant on [currentCityProvider].
final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvide);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);
