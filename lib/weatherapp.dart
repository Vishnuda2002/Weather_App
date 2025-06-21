import 'dart:convert';
import 'dart:ui';

import 'package:weather_app/additional_info.dart';
import 'package:weather_app/forcastview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secretes.dart';
import 'package:intl/intl.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late Future<Map<String, dynamic>> weather;

  // double temp=0;

  @override
  void initState() {
    super.initState();
    weather = getCurrentInfo();
    // getCurrentInfo();
  }

  Future<Map<String,dynamic>> getCurrentInfo() async{

    try {
      String cityName = "Erode";
      final res = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey"),
      );
      final data = jsonDecode(res.body);

      if (data['cod']!='200'){
          throw 'An unexpected error occured ';
      }

      return data;


      //setState(() {
       // temp=data ['list'][0]['main']['temp'];

      //});

    } catch(e) {
     throw e.toString();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather App",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ) ,
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              setState(() {
                weather = getCurrentInfo();
              });
            },
              icon: Icon(Icons.refresh),),
          ],
        ),

      body:
      //temp == 0 ? const CircularProgressIndicator():

      FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ){
            return Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentWeatherData =data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final Pressure = currentWeatherData ['main']['pressure'];
          final windSpeed = currentWeatherData ['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];



            return Padding(
        padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),

          SizedBox(
            width: double.infinity,

          child:  Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10,sigmaY: 10
              ),
            child: Padding(
              padding: EdgeInsets.all(8),
            child: Column(
            children:[ Text("$currentTemp K ",

              //"${temp.toStringAsFixed(3)} K",

            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            ),
              Icon(
                  currentSky == 'Clouds' || currentSky == 'Rain' ? Icons.cloud : Icons.sunny,
                size: 64),
              Text(currentSky,
              style: TextStyle(
                fontSize: 20,
              ),
              ),
            ],
          ),
          ),
          ),
          ),
          ),
          ),

          SizedBox(height: 20),


           Text("Hourly Forecast",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 8),

          //  SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          // child: Row(
          //   children: [
          //     for(int i = 0 ; i<20; i++)
          //     ForcastView(
          //         time: data['list'][i+1]['dt'].toString(),
          //         icon: data['list'][i+1]['weather'][0]['main'] == 'Cloud' || data['list'][i+1]['weather'][0]['main'] == 'Rain' ? Icons.cloud : Icons.sunny ,
          //         temperature: data['list'][i+1]['main']['temp'].toString(),
          //     ),
          //
          //   ],
          // ),
          // ),

          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: 30,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                final hourlyForecast = data['list'][index+1];
                final hourlySky =data['list'][index+1]['weather'][0]['main'];
                final hourltemp = hourlyForecast['main']['temp'];
                
                final time = DateTime.parse(hourlyForecast['dt_txt']);

                return ForcastView(
                    time: DateFormat.j().format(time),
                    icon: hourlySky == 'Cloud' || hourlySky == 'Rain' ? Icons.cloud : Icons.sunny,
                    temperature: hourltemp.toString(),
                );
              },
            ),
          ),



          SizedBox(height: 10),

          Text("Additional Information",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 2),


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            AdditionalInfo(
              icon: Icons.water_drop,
              label: "Humidity",
              value: currentHumidity.toString(),
            ),
            AdditionalInfo(
              icon: Icons.air,
              label: "Wind Speed",
              value: windSpeed.toString(),
            ),
            AdditionalInfo(
              icon: Icons.beach_access,
              label: "Pressure",
              value: Pressure.toString(),
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


