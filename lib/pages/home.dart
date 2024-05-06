import 'package:flutter/material.dart';

import 'package:weather_app/services/getWeather.dart';
import 'package:weather_app/widget/getDateTime.dart';
import 'package:weather_app/widget/imageUrl.dart';
import 'package:weather_app/widget/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> _weatherData;
  GetDateTime dateTimeConverter = GetDateTime();

  String input = 'New york';
  final TextEditingController locationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    locationController.text = input;
    final getData = GetData(location: input, value: "c");
    _weatherData = getData.fetchingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'WEATHER APP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'What is the city you live in?',
                  border: const OutlineInputBorder(),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        input = locationController.text;
                      });

                      final getData = GetData(location: input, value: "c");
                      setState(() {
                        _weatherData = getData.fetchingData();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder<Map<String, dynamic>>(
                    future: _weatherData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final weatherData = snapshot.data!;
                        String weatherStatus =
                            weatherData['current_observation']['condition']
                                    ['text']
                                .toString();
                        ImageWeather imageWeather =
                            ImageWeather(status: weatherStatus);
                        String imageUrl = imageWeather.getImageUrl();
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset('assets/pin.png'),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        weatherData['location']['city'],
                                        style: const TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' ,${weatherData['location']['country']}',
                                        style: const TextStyle(
                                          fontSize: 25.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        dateTimeConverter.formatCurrentDate(),
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ', ${dateTimeConverter.convertFromEpochToMonthName(
                                              weatherData['current_observation']
                                                  ['pubDate'],
                                            ).toString()}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 96, 202, 237),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.asset(imageUrl),
                                            ),
                                            Text(
                                              weatherData['current_observation']
                                                  ['condition']['text'],
                                              style: const TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${weatherData['current_observation']['condition']['code']}°',
                                          style: const TextStyle(
                                              fontSize: 60.0,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/windspeed.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ' ${weatherData['current_observation']['wind']['speed'].toString()} km/h',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/humidity.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ' ${weatherData['current_observation']['atmosphere']['humidity'].toString()}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/max-temp.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ' ${weatherData['current_observation']['condition']['temperature'].toString()}C',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/sunrise.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ' ${weatherData['current_observation']['astronomy']['sunrise'].toString()}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                child: Image.asset(
                                                    'assets/sunset.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ' ${weatherData['current_observation']['astronomy']['sunset'].toString()}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(
                                  'Next 10 Days',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 96, 202, 237),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: weatherData['forecasts'].length,
                                itemBuilder: (context, index) {
                                  final forecast =
                                      weatherData['forecasts'][index];
                                  String dateparse = dateTimeConverter
                                      .convertEpochToDateString(
                                          forecast['date']);
                                  bool isDateAfterNow(String dateString) {
                                    DateTime date = DateTime.parse(dateString);
                                    DateTime now = DateTime.now();

                                    return date.isAfter(now);
                                  }

                                  String status = forecast['text'].toString();

                                  ImageWeather imageWeather =
                                      ImageWeather(status: status);
                                  String imagebottom =
                                      imageWeather.getImageUrl();
                                  return Container(
                                    margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: isDateAfterNow(dateparse)
                                          ? Colors.blue
                                          : const Color.fromARGB(
                                              255, 183, 111, 250),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: !isDateAfterNow(dateparse)
                                          ? Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Today',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                WeatherItem(
                                                  image: imagebottom,
                                                  day: forecast['day'],
                                                  date: dateTimeConverter
                                                      .convertFromEpochToMonthName(
                                                          forecast['date']),
                                                  highValue: forecast['high'],
                                                  lowValue: forecast['low'],
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: const Text(
                                                    '',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.transparent,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                WeatherItem(
                                                  image: imagebottom,
                                                  day: forecast['day'],
                                                  date: dateTimeConverter
                                                      .convertFromEpochToMonthName(
                                                          forecast['date']),
                                                  highValue: forecast['high'],
                                                  lowValue: forecast['low'],
                                                ),
                                              ],
                                            ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
