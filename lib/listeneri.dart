import 'package:flutter/material.dart';
import 'package:json_data/home.dart';

class Listeneri extends StatefulWidget {
  const Listeneri({super.key});

  @override
  State<Listeneri> createState() => _ListeneriState();
}

class _ListeneriState extends State<Listeneri> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('listener'),),
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: counterNotifier,
            builder: (context, value, _) {
              return Text("$value");
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counterNotifier.value++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
