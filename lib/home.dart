import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> customersData = [];
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
    print(jsonEncode(customers));
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
      isLoading = false;
      customersData = response['data'];
      
      print(customersData);
    } else {
      print("Failed to load Data from json");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: customersData
                  .map((e) => ListTile(
                        title: Text(e["name"]),
                      ))
                  .toList(),
            ),
    );
  }
}
