import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/landing_screen.dart';
import 'package:flutter_application_1/widget/list_car_by_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingPage(widget: ListCarByClass()),
    );
  }
}
