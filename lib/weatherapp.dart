import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additionalinfo.dart';
import 'package:weather_app/apikey.dart';
import 'package:weather_app/hourlyforcastitem.dart';
import 'package:http/http.dart' as http;

class weatherscr extends StatefulWidget {
  const weatherscr({super.key});

  @override
  State<weatherscr> createState() => _weatherscrState();
}

class _weatherscrState extends State<weatherscr> {
  Future<Map<String, dynamic>> getweather() async {
    try {
      String cityname = "Agartala";
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$apikey"));
      final data = jsonDecode(res.body);
      if (data['cod'] != "200") {
        throw "An Unexpected error occured";
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            setState(() {
              
            });
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: getweather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currenttemp = data['list'][0]['main']['temp'];
          final currentsky = data['list'][0]['weather'][0]['main'];
          final humid = data['list'][0]['main']['humidity'];
          final pressure = data['list'][0]['main']['pressure'];
          final speedo = data['list'][0]['wind']['speed'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$currenttemp K",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Icon(
                                currentsky == "Clouds" || currentsky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                currentsky,
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Weather Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final time = DateTime.parse(data['list'][index + 1]['dt_txt']);
                      return hourforcast(
                         time: DateFormat.j().format(time),
                              temp:
                                  data['list'][index + 1]['main']['temp'].toString(),
                              win: data['list'][index + 1]['weather'][0]['main'] ==
                                          "Clouds" ||
                                      data['list'][index + 1]['weather'][0]['main'] ==
                                          "Rainy"
                                  ? Icons.cloud
                                  : Icons.sunny
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Additionalinfo(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      bablu: humid.toString(),
                    ),
                    Additionalinfo(
                      icon: Icons.air,
                      label: "Wind speed",
                      bablu: speedo.toString(),
                    ),
                    Additionalinfo(
                      icon: Icons.beach_access,
                      label: "Pressure",
                      bablu: pressure.toString(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
