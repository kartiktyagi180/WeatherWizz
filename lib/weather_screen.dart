import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_mine/add_info.dart';
import 'package:app_mine/hourly_forecast.dart';
import 'package:app_mine/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future getWeatherData() async {
    try {
      final result = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=$openWeatherAPIkey'));

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw "An unexpected error occurred";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 46, 75),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 46, 75),
          title: const Text("WeatherWizz"),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
          centerTitle: true,
          shadowColor: Colors.brown[600],
          toolbarHeight: 80,
          leading: const Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 0, 0),
            child: Icon(
              Icons.cloud,
              color: Colors.amber,
              size: 60,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _refresh,
              icon: const Icon(Icons.refresh),
              color: const Color.fromARGB(255, 255, 255, 255),
              splashColor: Colors.white,
            ),
          ]),
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text(
              "An expected error has occurred!",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ));
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            final currentTemp = data['list'][0]['main']['temp'];
            final currentSky = data['list'][0]['weather'][0]['main'];
            final currentHumidity = data['list'][0]['main']['humidity'];
            final currentPressure = data['list'][0]['main']['pressure'];
            final currentWindSpeed = data['list'][0]['wind']['speed'];

            return Center(
              child: Column(
                children: [
                  const SizedBox(width: 00, height: 30),
                  Container(
                    width: 380,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: const Color.fromARGB(255, 10, 30, 35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text("$currentTemp K",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 30)),
                                const SizedBox(width: 00, height: 4),
                                currentSky == 'Rain' || currentSky == 'Clouds'
                                    ? const Icon(Icons.cloud_sharp,
                                        size: 60, color: Colors.white)
                                    : const Icon(Icons.wb_sunny_rounded,
                                        size: 60, color: Colors.white),
                                const SizedBox(width: 00, height: 10),
                                Text(currentSky,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 252, 252, 252),
                                        fontSize: 30)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 00, height: 15),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text("Weather Forecast",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 00, height: 00),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 10, 17, 10),
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return HourlyForecastItems(
                                time: data['list'][index]['dt_txt']
                                    .substring(11, 16),
                                icon: data['list'][index]['weather'][0]['main'] ==
                                            'Clouds' ||
                                        data['list'][index]['weather'][0]['main'] ==
                                            'Rain'
                                    ? Icons.cloud_sharp
                                    : Icons.wb_sunny_rounded,
                                temp: data['list'][index]['main']['temp']
                                    .toString());
                          }),
                    ),
                  ),
                  const SizedBox(width: 00, height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text("Additional Information",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 00, height: 1),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Row(
                          children: [
                            AddInfoCards(
                                category: "Humidity",
                                icon: Icons.water_drop,
                                temp: "$currentHumidity"),
                            AddInfoCards(
                                category: "Wind Speed",
                                icon: Icons.air,
                                temp: "$currentWindSpeed"),
                            AddInfoCards(
                                category: "Pressure",
                                icon: Icons.beach_access,
                                temp: "$currentPressure"),
                          ],
                        )),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                      color: Color.fromARGB(255, 3, 29, 41),
                      backgroundColor: Color.fromARGB(255, 13, 85, 121)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text(
                      "Please wait...",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
