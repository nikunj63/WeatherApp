import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/Models/weather_model.dart';

class WeatherServices {
  fetchWeather()async{
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=26.8467&lon=80.9462&appid=a0c85dfaf217ca2ff3c9484adffa21d4'));
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      }else{
        throw Exception('Failed to load Weather Data');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}