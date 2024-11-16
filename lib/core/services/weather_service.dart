import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../class/request_status.dart';
import '../functions/check_internet_function.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';

  String apiKey = '04b50fa13f0e4ad68b2231053241411';

  Future<Either<RequestStatus, dynamic>> getWeather(
      {required String cityName}) async {
    try {
      if (await checkInternetFunction()) {
        Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');

        http.Response response = await http.get(url);
        // print(response.statusCode);
        if (response.statusCode == 200 ||
            response.statusCode == 201 ||
            response.statusCode == 202) {
          Map receivedData = jsonDecode(response.body);

          return right(receivedData);
        } else {
          return left(RequestStatus.serverFailure);
        }
      } else {
        return left(RequestStatus.offline);
      }
    } catch (e) {
      return left(RequestStatus.serverException);
    }
  }

  getWeatherData(String cityName) async {
    var response = await getWeather(cityName: cityName);
    return response.fold((l) => l, (r) => r);
  }
}
