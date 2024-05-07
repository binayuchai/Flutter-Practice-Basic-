import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// Process
// -----------------
// Fetch data from internet -----> Convert into Dart Objects




// -----------------


class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'userId': int userId,
      'id': int id,
      'title': String title,
      } =>
          Album(
            userId: userId,
            id: id,
            title: title,
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}


void main() {
  runApp(const MyApp());
}

//function that fetches an album from the internet
Future<Album> fetchAlbum() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  //here http.get() returns a Future that contains a Response
  // http.Response class contains the data received from a successful http call.
  if(response.statusCode == 200){
    // if the server did return a 200 OK response,
    //then parse the JSON
    return Album.fromJson(jsonDecode(response.body) as Map<String,dynamic>);

  }else{
    // In case of Exception
    throw Exception('Failed to load album');
  }

}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Album> futureAlbum;

  // we are using initState to fetch album because if we use inside build method ,method will
  // call api again and again with change in ui
  // if we use inside initState it will get fetched only once
  @override
  void initState(){
    super.initState();
    futureAlbum = fetchAlbum();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Center(child:Text('Weather App')),
        ),

        body:Center(
            child: FutureBuilder<Album>(
                future:futureAlbum,
                builder: (context,snapshot){  //'snapshot' is used to represent the current state of
                  //of asynchronous operation
                  if(snapshot.hasData){ // checks does snapshot contains data returns bool
                    return Text(snapshot.data!.title);
                    // here we are accessing the data stored within the snapshot
                    // where in this case is:   title of instance

                    // '!' -> this is assertion operator that checks snapshot.data is not Null.
                  }
                  else if(snapshot.hasError){
                    return Text('${snapshot.error}');

                  }

                  //By default,show a loading spinner
                  return const CircularProgressIndicator();
                }
            )


        )
    );
  }
}

