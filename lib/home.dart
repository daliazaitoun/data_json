import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_data/listeneri.dart';
import 'package:json_data/model/customer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

var counterNotifier = ValueNotifier(0);

class _HomePageState extends State<HomePage> {
  List<Customer> customersData = [];
  final customers = [
    {
      'id': 1,
      'name': 'John Doe',
      'email': 'john.doe@example.com',
    },
    {
      'id': 2,
      'name': 'Jane Smith',
      'email': 'jane.smith@example.com',
    }
  ];
  bool isLoading = false;
  @override
  void initState() {
    print(jsonEncode(customers)); // Encode the customers list

    initcustomers();
    super.initState();
  }

  void initcustomers() async {
    setState(() {
      isLoading = true;
    });
    var result = await rootBundle.loadString('assets/data.json');
    var response = jsonDecode(result);
    if (response['success']) {
      customersData = List<Customer>.from(
          response['data'].map((e) => Customer.fromJson(e)).toList());

      print(customersData);
    } else {
      print("Failed to load Data from json");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Listeneri()));
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: customersData
                        .map((e) => ListTile(
                              title: Text(e.name),
                            ))
                        .toList(),
                  ),
                  ValueListenableBuilder(
                      valueListenable: counterNotifier,
                      builder: (context, value, _) {
                        return Text("$value");
                      }),
                  ElevatedButton(onPressed: () {
                    counterNotifier.value++;
                  }, child: Text("Change notifier"))
                ],
              ),
            ),
    );
  }
}
