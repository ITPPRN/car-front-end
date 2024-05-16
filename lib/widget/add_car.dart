import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  State<AddCarPage> createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final String apiUrl = 'http://127.0.0.1:80/v1/car';

  final TextEditingController serialNoController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Future<void> sendCarData() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(apiUrl));
    request.body = json.encode({
      "SerialNo": int.tryParse(serialNoController.text),
      "Brand": brandController.text,
      "Model": modelController.text,
      "Manufacturer": manufacturerController.text,
      "Price": int.tryParse(priceController.text)
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: serialNoController,
                decoration: const InputDecoration(
                labelText: 'Serial No',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: brandController,
              decoration: const InputDecoration(
                labelText: 'Brand',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: modelController,
              decoration: const InputDecoration(
                labelText: 'Model',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: manufacturerController,
              decoration: const InputDecoration(
                labelText: 'Manufacturer',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendCarData,
              child: const Text('Send Car Data'),
            ),
          ],
        ),
      ),
    );
  }
}
