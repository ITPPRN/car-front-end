import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/add_car.dart';
import 'package:flutter_application_1/widget/car_total_price.dart';
import 'package:flutter_application_1/widget/list_by_option.dart';
import 'package:flutter_application_1/widget/list_car_by_class.dart';
import 'package:flutter_application_1/widget/sales_person_result.dart';
import 'package:flutter_application_1/widget/saqles_summary.dart';

class LandingPage extends StatefulWidget {
  final Widget widget;

  const LandingPage({super.key, required this.widget});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget currentWidget = const ListCarByClass();

  void setCurrentWidget(Widget? widget) {
    currentWidget = widget!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setCurrentWidget(widget.widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            //headDrawer(),
            addCar(),
            listCarByClass(),
            listCarByOptions(),
            listCarTotalPrice(),
            listSalesPerson(),
            listSalesSummary()
          ],
        ),
      );

  UserAccountsDrawerHeader headDrawer() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bg_dr.jpg'), fit: BoxFit.cover),
      ),
      currentAccountPicture: Container(
        width: 100,
        height: 100,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: CircleBorder(),
          image: DecorationImage(
              image: AssetImage('images/Untitled-1.png'), fit: BoxFit.fill),
        ),
      ),
      accountName: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          "",
          style: TextStyle(color: Colors.white),
        ),
      ),
      accountEmail: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Welcome',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          )),
    );
  }

  ListTile addCar() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("addCar"),
      onTap: () {
        currentWidget = const AddCarPage();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }

  ListTile listCarByClass() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("listCarByClass"),
      onTap: () {
        currentWidget = const ListCarByClass();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }

  ListTile listCarByOptions() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("listCarByOptions"),
      onTap: () {
        currentWidget = const ListCarByOption();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }

  ListTile listCarTotalPrice() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("listCarTotalPrice"),
      onTap: () {
        currentWidget = const CarTotalPrice();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }

  ListTile listSalesPerson() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("listSalesPerson"),
      onTap: () {
        currentWidget = const ListSaalesPerson();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }

  ListTile listSalesSummary() {
    return ListTile(
      leading: const Icon(Icons.home),
      title: const Text("listSalesSummary"),
      onTap: () {
        currentWidget = const SalesSummary();
        setState(() {});

        Navigator.pop(context);
      },
    );
  }
}
