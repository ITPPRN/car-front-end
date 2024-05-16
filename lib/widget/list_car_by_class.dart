import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListCarByClass extends StatefulWidget {
  const ListCarByClass({Key? key}) : super(key: key);

  @override
  State<ListCarByClass> createState() => _ListCarByClassState();
}

class _ListCarByClassState extends State<ListCarByClass> {
  final List<String> carClasses = [
    'economiccar',
    'expensivecar',
    'luxuriouscar'
  ];
  String selectedCarClass = 'economiccar'; // Default selected car class
  List<dynamic> carData = [];

  @override
  void initState() {
    super.initState();
    // Fetch car data immediately when the widget is initialized
    fetchCarData();
  }

  Future<void> fetchCarData() async {
    final String apiUrl =
        'http://127.0.0.1:80/v1/car/cars/class/$selectedCarClass';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // Align DropdownButton to the left side
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<String>(
                    value: selectedCarClass,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCarClass = newValue!;
                        // When the selected car class changes, fetch data immediately
                        fetchCarData();
                      });
                    },
                    items: carClasses
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: carData.isNotEmpty
                  ? ListView.builder(
                      itemCount: carData.length,
                      itemBuilder: (context, index) {
                        var car = carData[index];
                        return Card(
                          child: ListTile(
                            title: Text('${car['Brand']} ${car['Model']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Serial No: ${car['SerialNo']}'),
                                Text('Manufacturer: ${car['Manufacturer']}'),
                                Text('Price: \$${car['Price']}'),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child:
                          CircularProgressIndicator(), // Show loading indicator when data is being fetched
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
