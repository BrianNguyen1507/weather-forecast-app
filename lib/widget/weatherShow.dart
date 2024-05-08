import 'package:flutter/material.dart';
import 'package:weather_app/pages/detail.dart';
import 'package:weather_app/widget/getDateTime.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({
    super.key,
    required this.code,
    required this.highValue,
    required this.lowValue,
    required this.time,
    required this.image,
  });

  final double highValue;
  final double lowValue;
  final String time;
  final String image;
  final int code;
  @override
  Widget build(BuildContext context) {
    GetDateTime format = GetDateTime();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailPage(
              code: code,
              date: time,
              highTemperatureCelsius: highValue,
              lowTemperatureCelsius: lowValue,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: format.isDateAfterNow(time)
              ? Colors.blue
              : const Color.fromARGB(255, 183, 111, 250),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: !format.isDateAfterNow(time)
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              '${lowValue.toString()}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' - ${highValue.toString()}°C ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(image),
                      ),
                      Text(
                        format.convertToMonthName(time),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '${lowValue.toString()}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' - ${highValue.toString()}°C ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(image),
                  ),
                  Text(
                    format.convertToMonthName(time),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
