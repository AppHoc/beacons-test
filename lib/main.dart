import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void setup() async {
    try {
      await flutterBeacon.initializeAndCheckScanning;
    } on PlatformException catch (e) {
      print(e);
    }

    final regions = <Region>[];

    regions.add(Region(identifier: 'Hai', proximityUUID: 'FDA50693-A4E2-4FB1-AFCF-C6EB07647806'));

    flutterBeacon.monitoring(regions).listen((MonitoringResult result) {
      print("Monitored beacon ${result.region.identifier}");
    });

    flutterBeacon.ranging(regions).listen((event) {
      print("Ranged beacon ${event.region.identifier}");
    });
    
  }

  @override
  Widget build(BuildContext context) {
    setup();
    
    return Text("Started ranging");
  }
}
