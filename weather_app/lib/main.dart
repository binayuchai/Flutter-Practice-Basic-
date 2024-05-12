import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screens/home.dart';
import '../screens/loading.dart';

// Process
// -----------------
// Fetch data from internet -----> Convert into Dart Objects




// -----------------


void main() {
  runApp(const MyApp());
}








class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes:{
        '/loading': (context) => SelectLocation(),
        '/weather': (context){
          final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
          final weatherData = args['weatherData'] as Map<String,dynamic>;
          final selectedLocation = args['selectedLocation'] as String;
          return HomeScreen(weatherData: weatherData,selectedLocation: selectedLocation);
        }
      }
    );
  }
}





