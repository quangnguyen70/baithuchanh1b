import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class Todo {
  String city;
  String weather;
  double temperature;

  Todo(this.city, this.weather, this.temperature);
}

class _WeatherAppState extends State<WeatherApp> {
  final String apiKey = '933dab85a2c5b8ea7b9d0d04499c94fd';
  final cityController = TextEditingController();
  String city = '';
  String weather = '';
  double temperature = 0.0;

  void fetchWeatherData() async {
    final cityName = cityController.text;
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        city = jsonData['name'];
        weather = jsonData['weather'][0]['description'];
        temperature = jsonData['main']['temp'] - 273.15; // Convert temperature from Kelvin to Celsius
      });
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            city: city,
            weather: weather,
            temperature: temperature,
          ),
        ),
      );
    } else {
      setState(() {
        city = 'City not found';
        weather = '';
        temperature = 0.0;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Thời tiết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Nhập khu vực mong muốn',
                fillColor: Colors.black87,
              ),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              onPressed: fetchWeatherData,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search),
                    Text('Tìm kiếm'),
                  ],
                ),
              ),
              style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(color: Colors.blueAccent),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String city;
  final String weather;
  final double temperature;

  SecondScreen({required this.city, required this.weather, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Thông tin thời tiết tại khu vực"),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text(
                'Thành phố: $city',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 8),
              Image.network(
                'https://play-lh.googleusercontent.com/xYIuKkCItAvBSC1E0u0e7SGTc70V3eN-_VDK8dzbdop-gH8aqTu2gwt_hJab0HruW6r_',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 8),
              Text(
                'Thời tiết: $weather',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Nhiệt độ: ${temperature.toStringAsFixed(1)} °C',
                style: const TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Quay lại'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

