import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

/// Supply the key at build/run time with:
/// flutter run --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY
const apiKey = String.fromEnvironment('OPENWEATHER_API_KEY');
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    if (apiKey.isEmpty) {
      throw StateError(
        'Missing OpenWeatherMap API key. '
        'Pass --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY.',
      );
    }

    final encodedCity = Uri.encodeQueryComponent(cityName);
    final networkHelper = NetworkHelper(
      '$openWeatherMapURL?q=$encodedCity&appid=$apiKey&units=metric',
    );

    return networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    if (apiKey.isEmpty) {
      throw StateError(
        'Missing OpenWeatherMap API key. '
        'Pass --dart-define=OPENWEATHER_API_KEY=YOUR_API_KEY.',
      );
    }

    final location = Location();
    await location.getCurrentLocation();

    final networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}'
      '&appid=$apiKey&units=metric',
    );

    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return "You'll need 🧣 and 🧤";
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
