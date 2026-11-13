import 'package:flutter_test/flutter_test.dart';
import 'package:clima/services/weather.dart';

void main() {
  group('WeatherModel.getWeatherIcon', () {
    final weather = WeatherModel();

    test('maps thunderstorm conditions', () {
      expect(weather.getWeatherIcon(200), '🌩');
      expect(weather.getWeatherIcon(299), '🌩');
    });

    test('maps drizzle and rain conditions', () {
      expect(weather.getWeatherIcon(300), '🌧');
      expect(weather.getWeatherIcon(500), '☔️');
    });

    test('maps snow and atmosphere conditions', () {
      expect(weather.getWeatherIcon(600), '☃️');
      expect(weather.getWeatherIcon(700), '🌫');
    });

    test('maps clear and cloudy conditions', () {
      expect(weather.getWeatherIcon(800), '☀️');
      expect(weather.getWeatherIcon(801), '☁️');
      expect(weather.getWeatherIcon(804), '☁️');
    });

    test('uses a fallback for unrecognized conditions', () {
      expect(weather.getWeatherIcon(900), '🤷‍');
    });
  });

  group('WeatherModel.getMessage', () {
    final weather = WeatherModel();

    test('selects the hot-weather message above 25 degrees', () {
      expect(weather.getMessage(26), "It's 🍦 time");
    });

    test('selects the shorts message above 20 through 25 degrees', () {
      expect(weather.getMessage(21), 'Time for shorts and 👕');
      expect(weather.getMessage(25), 'Time for shorts and 👕');
    });

    test('selects the cold-weather message below 10 degrees', () {
      expect(weather.getMessage(9), "You'll need 🧣 and 🧤");
    });

    test('uses the jacket message at remaining boundaries', () {
      expect(weather.getMessage(10), 'Bring a 🧥 just in case');
      expect(weather.getMessage(20), 'Bring a 🧥 just in case');
    });
  });
}
