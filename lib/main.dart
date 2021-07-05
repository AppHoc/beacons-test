import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

/*

In order to use beacons related features, apps are required to ask the location permission. It's a two step process:

Declare the permission the app requires in configuration files
Request the permission to the user when app is running (the plugin can handle this automatically)
The needed permissions in iOS is when in use.

For more details about what you can do with each permission, see:
https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services

*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
      print("Found beacon ${result.region.identifier}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: setup, child: Text("Press me to setup"),);
  }
}
