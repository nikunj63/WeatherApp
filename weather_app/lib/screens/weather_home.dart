import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/Services/services.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  WeatherData? weatherInfo;
  bool isLoading = true;

  myWeather() {
    WeatherServices().fetchWeather().then((value) {
      setState(() {
        weatherInfo = value;
        isLoading = false; // Data has been loaded
      });
    });
  }

  @override
  void initState() {
    super.initState();
    weatherInfo = WeatherData(temperature: 0); // Initialize with a default value
    myWeather(); // Fetch the weather data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xFF676BD0),
      ),
      backgroundColor: const Color(0xFF676BD0),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: WeatherDetail(
                  weather: weatherInfo!,
                  formattedDate: '', // Add actual date formatting logic
                  formattedTime: '', // Add actual time formatting logic
                ),
              ),
      ),
    );
  }
}


class WeatherDetail extends StatelessWidget {
  final WeatherData weather;
  final String formattedDate;
  final String formattedTime;
  const WeatherDetail({super.key,required this .weather,required this.formattedDate,required this.formattedTime});

  @override
  Widget build(BuildContext context) {
     double  temperatureInCelsius = (weather.main?.temp ?? 0) - 273.15;

       String weatherCondition = weather.weather?.isNotEmpty == true
        ? weather.weather![0].main ?? 'Unknown Condition'
        : 'Unknown Condition';

        String formattedDate = DateFormat('EEEE D,MMMM yyyy').format(
          DateTime.now()
        );
        String formattedTime = DateFormat('hh:mm a').format(
          DateTime.now()
        );

    return Column(
      children: [
         Text(weather.name ?? 'Unknown location',
        style:const TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ) ,
        ),
        Text('${temperatureInCelsius.toStringAsFixed(1)} °C',
        style:const TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ) ,
        ),
        Text(weatherCondition,
        style:const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ) ,
        ),
       const SizedBox(height: 30,),
       Text(
        formattedDate,
        style:const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ) ,
        ),
        Text(
        formattedTime,
        style:const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ) ,
        ),
        const SizedBox(height: 30,),
        Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/cloudy.png'
              )
            )
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,horizontal: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.wind_power,
                          color: Colors.lightGreenAccent,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "Wind",
                            value: "${weather.wind!.speed} km/h"
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sunny,
                          color: Colors.amber,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "Max",
                            value: "${(weather.main!.tempMax!-273.15).toStringAsFixed(1)}°C"
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.sunny,
                          color: Colors.amberAccent,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "Min",
                            value: "${(weather.main!.tempMin! - 273.15).toStringAsFixed(1)}°C"
                            ),
                        ],
                      )
                    ],
                  ),
                 const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.water_drop,
                          color: Colors.lightBlue,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "Humidity",
                            value: "${weather.main!.humidity}% "
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.air,
                          color: Colors.white,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "Pressure",
                            value: "${weather.main!.pressure}hpa"
                            ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.leaderboard,
                          color: Colors.redAccent,
                          ),
                         const SizedBox(height: 5,),
                          weatherInfoCard( 
                            title: "SeaLevel",
                            value: "${weather.main!.seaLevel}m"
                            ),
                        ],
                      )
                    ],
                  )
                ],
              ),
          ),
        )
      ],
    );
  }

  Column weatherInfoCard({
    required String title,required String value
  }) {
    return  Column(
                          children: [
                            Text(value,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),
                            ),
                            Text(title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                            ),
                          ],
                        );
  }
}