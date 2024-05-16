import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListCarByOption extends StatefulWidget {
  const ListCarByOption({Key? key}) : super(key: key);

  @override
  State<ListCarByOption> createState() => _ListCarByOptionState();
}

class _ListCarByOptionState extends State<ListCarByOption> {
  final TextEditingController optionController = TextEditingController();
  List<dynamic> carData = [];

  Future<void> fetchCarData() async {
    final String option = optionController.text;
    final String apiUrl =
        'http://127.0.0.1:80/v1/car/cars/option?option=${Uri.encodeQueryComponent(option)}';
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
      print(carData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      controller: optionController,
                      decoration: const InputDecoration(
                        labelText: 'Options (comma separated)',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: fetchCarData,
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: carData.isNotEmpty && carData != []
                  ? ListView.builder(
                      itemCount: carData.length,
                      itemBuilder: (context, index) {
                        final car = carData[index];
                        return Card(
                          child: ListTile(
                            title: Text('${car['brand']} ${car['model']}'),
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
