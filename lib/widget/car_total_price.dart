import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarTotalPrice extends StatefulWidget {
  const CarTotalPrice({super.key});

  @override
  State<CarTotalPrice> createState() => _CarTotalPriceState();
}

class _CarTotalPriceState extends State<CarTotalPrice> {
  List<dynamic> carData = [];

  Future<void> fetchCarData() async {
    const String apiUrl = 'http://127.0.0.1:80/v1/car/cars/total';
    var request = http.Request('GET', Uri.parse(apiUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedResponse = json.decode(responseBody);
      if (parsedResponse['data'] != null) {
        carData = parsedResponse['data'];
      } else {
        carData = [];
      }
      setState(() {});
    } else {
      setState(() {
        carData = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: carData.isNotEmpty
                  ? ListView.builder(
                      itemCount: carData.length,
                      itemBuilder: (context, index) {
                        var car = carData[index];
                        return Card(
                          child: ListTile(
                            title: Text('${car['brand']} ${car['model']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Serial No: ${car['serial_no']}'),
                                Text('Car Price: \$${car['car_price']}'),
                                Text(
                                    'Total Option Price: \$${car['total_option_price']}'),
                                Text('Total Price: \$${car['total_price']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No data available'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
