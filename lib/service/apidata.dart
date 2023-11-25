import 'dart:convert';
import 'package:http/http.dart' as http;

class GetData {
  Future<Map<String, dynamic>> getWeatherData(String city) async {
    try {
      final apiKey = '19394883c5107308a125cc75c21da3cc';
      final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(city)}&appid=$apiKey';

      final response = await http.get(Uri.parse(apiUrl));
      final data = json.decode(response.body);

      return data;
    } catch (error) {
      print('Error fetching weather data: $error');
      throw error;
    }
  }
}

GetData getdata = GetData();
