import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/module/LocalCurrentPermissions.dart';
import 'package:weather_app/services/forecastWeather.dart';
import 'package:weather_app/services/geoapifyApi.dart';
import 'package:weather_app/widget/getDateTime.dart';
import 'package:weather_app/widget/weatherUrl.dart';
import 'package:weather_app/widget/weatherShow.dart';
import 'package:weather_app/widget/weatherCode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>>? _weatherData;
  late Future<Map<String, dynamic>>? _localtionData;
  PermisstionsLocation permisstionsLocation = PermisstionsLocation();
  GetDateTime getDate = GetDateTime();
  bool currentFlag = false;
  final TextEditingController locationController = TextEditingController();
  String? _latitude;
  String? _longitude;

  @override
  void initState() {
    super.initState();
    _weatherData = null;
    _localtionData = null;
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    String location = locationController.text.toString();

    if (location.isEmpty) {
      _getCurrentLocation();
    } else {
      await _fetchAndSetLocationAndWeather(location);
    }
  }

  Future<void> _fetchAndSetLocationAndWeather(String location) async {
    final getGeoapify = Geoapify(location: location);
    var locationData = await getGeoapify.fetchingLocation();
    String lat = locationData['features'][0]['properties']['lat'].toString();
    String lon = locationData['features'][0]['properties']['lon'].toString();
    final forecastWeather = Forecastweather(lat: lat, lon: lon);
    var weatherData = await forecastWeather.fetchingWeather();

    setState(() {
      _weatherData = Future.value(weatherData);
      _localtionData = Future.value(locationData);
    });
  }

  void _getCurrentLocation() async {
    try {
      Position position = await permisstionsLocation.determinePosition();
      setState(() {
        currentFlag = true;
        locationController.clear();
        locationController.text = 'Your Location';
        _latitude = position.latitude.toString();
        _longitude = position.longitude.toString();
        final forecastWeather =
            Forecastweather(lat: _latitude!, lon: _longitude!);
        var weatherData = forecastWeather.fetchingWeather();
        _weatherData = Future.value(weatherData);
      });
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'TODAY WEATHER',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'What is the city you live in?',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              currentFlag = false;
                              _loadSavedData();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: IconButton(
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      icon: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder<Map<String, dynamic>>(
                    future: _localtionData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        final locationData = snapshot.data!;
                        String text = locationData['features'][0]['properties']
                                ['formatted']
                            .toString();
                        const int maxLength = 35;
                        String shortenedText = text.length <= maxLength
                            ? text
                            : '${text.substring(0, maxLength)}...';
                        return Column(
                          children: [
                            Column(
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
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        currentFlag
                                            ? "Your Location"
                                            : shortenedText,
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: _weatherData,
                    builder: (context, weatherSnapshot) {
                      if (weatherSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (weatherSnapshot.hasError) {
                        return Center(
                          child: Text('Error: ${weatherSnapshot.error}'),
                        );
                      } else if (!weatherSnapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        Map<String, dynamic> weatherData =
                            weatherSnapshot.data!;
                        WeatherData data = WeatherData.fromJson(weatherData);
                        int weatherCode = data.current.weatherCode;
                        WeatherImage imageWeather =
                            WeatherImage(weatherCode: weatherCode);
                        String imageUrl = imageWeather.getImageUrl();

                        WeatherDescription description =
                            WeatherDescription(weatherCode: weatherCode);
                        String desWeather = description.getWeatherDescription();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                getDate.convertToMonthName(
                                  getDate
                                      .formatDate(data.current.time.toString()),
                                ),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Center(
                                child: Container(
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
                                              desWeather,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          '${data.current.temperature2m.toString()}${data.currentUnits.apparentTemperature.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40.0,
                                              color: Colors.white),
                                        ),
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
                                          '${data.current.windSpeed10m.toString()} ${data.currentUnits.windSpeed10m}',
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
                                                    data.current.isDay == 1
                                                        ? 'assets/sun.png'
                                                        : 'assets/moon.png'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          data.current.isDay == 1
                                              ? 'Day'
                                              : 'Night',
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
                                          '${data.current.relativeHumidity2m.toString()}${data.currentUnits.relativeHumidity2m.toString()}',
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
                                  'Next 3 Days',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 96, 202, 237),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 230.0,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: data.daily.time.length,
                                itemBuilder: (context, index) {
                                  int dailyCode = data.daily.weatherCode[index];

                                  WeatherImage imageDaily =
                                      WeatherImage(weatherCode: dailyCode);
                                  String imageUrlDaily =
                                      imageDaily.getImageUrl();
                                  return Center(
                                    child: WeatherItem(
                                      code: data.daily.weatherCode[index],
                                      image: imageUrlDaily,
                                      time: data.daily.time[index],
                                      highValue:
                                          data.daily.temperature2mMax[index],
                                      lowValue:
                                          data.daily.temperature2mMin[index],
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
          )
        ],
      ),
    );
  }
}
