



import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  String apiKey = "";
  TextEditingController _searchController = TextEditingController();
  String _selectedLocation = '';
  String _temperature = '';


  Future<Map<String,dynamic>> fetchWeatherData(String cityName) async{
    final response = await http.get(Uri.parse(
    "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey"

    ));

    if (response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Failed to load weather data');
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Select Location'),
      ),
      body:Padding(
        padding: EdgeInsets.all(16.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TypeAheadFormField(
               textFieldConfiguration: TextFieldConfiguration(
                 controller: _searchController,
                 decoration: const InputDecoration(
                   labelText: 'Search Location',
                   border:OutlineInputBorder(),
                 )
               ),
                suggestionsCallback: (pattern) async{
                 final response = await http.get(Uri.parse(
                   'http://api.openweathermap.org/data/2.5/find?q=$pattern&appid=$apiKey'
                 ));
                 if(response.statusCode == 200){
                   final data = json.decode(response.body);
                   final List<dynamic> locations = data['list'];
                   return (locations as List<dynamic>).map((location) => location['name'] as String).toList();
                 }
                 else{
                   return [];
                 }
                },
              itemBuilder: (context,suggestion){
                 return ListTile(
                   title:Text(suggestion.toString()),
                 );
              },


              onSuggestionSelected: (suggestion){
                 setState(() {
                   _selectedLocation = suggestion.toString();
                   _searchController.text = suggestion.toString();
                 });
              },

            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
                onPressed: () async{
                  if(_selectedLocation.isNotEmpty){
                    final weatherData = await fetchWeatherData(_selectedLocation);
                    setState(() {
                      _temperature = weatherData['main']['temp'].toString();
                    });
                    print(weatherData);


                    Navigator.pushNamed(context, '/weather',
                      arguments: {
                      'weatherData':weatherData,
                      'selectedLocation':_selectedLocation,});


                  }

                },
                child: Text('Get Weather'))


          ],
        )
      )
    );
  }
}
