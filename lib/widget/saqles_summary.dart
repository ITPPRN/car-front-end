import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SalesSummary extends StatefulWidget {
  const SalesSummary({super.key});

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  List<dynamic> salesSummaryData = [];

  Future<void> fetchSalesSummaryData() async {
    const String apiUrl = 'http://127.0.0.1:80/v1/sale/sales/summary';
    var request = http.Request('GET', Uri.parse(apiUrl));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedResponse = json.decode(responseBody);
      if (parsedResponse['data'] != null) {
        salesSummaryData = parsedResponse['data'];
      } else {
        salesSummaryData = [];
      }
      setState(() {});
    } else {
      setState(() {
        salesSummaryData = [];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSalesSummaryData();
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
              child: salesSummaryData.isNotEmpty
                  ? ListView.builder(
                      itemCount: salesSummaryData.length,
                      itemBuilder: (context, index) {
                        var salesSummary = salesSummaryData[index];
                        return Card(
                          child: ListTile(
                            title: Text(
                                'Month: ${salesSummary['Month']}, Year: ${salesSummary['Year']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Number of Cars Sold: ${salesSummary['num_cars_sold']}'),
                                Text(
                                    'Total Sales: \$${salesSummary['total_sales']}'),
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
