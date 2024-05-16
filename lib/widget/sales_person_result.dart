import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListSaalesPerson extends StatefulWidget {
  const ListSaalesPerson({super.key});

  @override
  State<ListSaalesPerson> createState() => _ListSaalesPersonState();
}

class _ListSaalesPersonState extends State<ListSaalesPerson> {
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController minSalesController = TextEditingController();
  List<dynamic> salesData = [];

  Future<void> fetchSalesData() async {
    final String month = monthController.text;
    final String year = yearController.text;
    final String minSales = minSalesController.text;

    final String apiUrl =
        'http://127.0.0.1:80/v1/sale/sales/employee?month=$month&year=$year&minSales=$minSales';
    var request = http.Request('GET', Uri.parse(apiUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedResponse = json.decode(responseBody);
      if (parsedResponse['data'] != null) {
        salesData = parsedResponse['data'];
      } else {
        salesData = [];
      }

      setState(() {});
    } else {
      setState(() {
        salesData = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: monthController,
              decoration: const InputDecoration(
                labelText: 'Month',
              ),
            ),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
              ),
            ),
            TextField(
              controller: minSalesController,
              decoration: const InputDecoration(
                labelText: 'Minimum Sales',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchSalesData,
              child: const Text('Fetch Sales Data'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: salesData.isNotEmpty
                  ? ListView.builder(
                      itemCount: salesData.length,
                      itemBuilder: (context, index) {
                        var salesPerson = salesData[index];
                        return Card(
                          child: ListTile(
                            title: Text('${salesPerson['name']}'),
                            subtitle: Text(
                                'Number of Cars Sold: ${salesPerson['num_cars_sold']}'),
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
