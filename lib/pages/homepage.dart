// ignore_for_file: use_build_context_synchronously

import 'package:dhis2_practical_interview/pages/weatherdata.dart';
import 'package:dhis2_practical_interview/service/apidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _areaController = TextEditingController();
  Future<String?>? _weatherData;

  Future<void> _fetchWeatherData(String area) async {
    setState(() {
      _weatherData = getdata.getWeatherData(area).then((data) {
        final String description = data['weather'][0]['description'];
        final double temperature = data['main']['temp'];
        return 'Weather: $description\nTemperature: $temperature °C';
      }).catchError((error) {
        return 'Error fetching weather data';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Search Weather',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:16.0,right: 16.0,top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo_ud.png', 
                width: 100, 
                height: 100, 
              ),
              const SizedBox(height: 20.0),
              Text("Welcome Please Enter Area \n Regional  Area to check Weather data",style: TextStyle(color: Colors.grey,fontSize: 18),textAlign: TextAlign.center,),
               const SizedBox(height: 20.0),
              TextField(
                controller: _areaController,
                decoration: InputDecoration(
                  labelText: 'Enter Area',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _fetchWeatherData(_areaController.text);
                },
                child: const Text('Search'),
              ),
              const SizedBox(height: 16.0),
              FutureBuilder<String?>(
                future: _weatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitCircle(color: Colors.blue); 
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error fetching weather data',
                      style: TextStyle(fontSize: 16.0),
                    );
                  } else {
                    if (snapshot.data != null && snapshot.data != '') {
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherData(
                              area: _areaController.text,
                              description: snapshot.data!,
                              temperature: double.parse(snapshot.data!.split('\n')[1].split(' ')[1]),
                            ),
                          ),
                        );
                      });
                    }
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
