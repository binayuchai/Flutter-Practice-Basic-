import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  final dynamic weatherData;
  final String selectedLocation;
  const HomeScreen({
    Key? key,  // Explicitly specifying key
  required this.weatherData,
  required this.selectedLocation
  }):super(key:key);



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int convertToC(double data){
     double fahrenheit = data;
     int celsius = (fahrenheit-273.15).toInt();
     return celsius;
   }
  @override
  Widget build(BuildContext context) {
    bool show_lon_lat = false;

    return Scaffold(
      appBar: AppBar(
        title:const Text('Weather App')
      ),
      body:RefreshIndicator(
        onRefresh: ()async{
          await Future.delayed(const Duration(seconds:1));

          // Navigate to the new page from current page to page given to the builder
          // like Navigating from login page to homepage

          // Navigator.pushReplacementNamed(context, '/loading',arguments: selectedLocation);
          // return null;
        },

        child:SafeArea(  // SafeArea -> It adds padding to its child widgets to avoid overlaps
            child:Padding(
              padding:const EdgeInsets.all(0),
              child:ListView(
                children: [
                  ClipPath(
                    clipper:OvalBottomBorderClipper(),
                    child:Container(
                      color:Colors.lightBlue,
                      padding: EdgeInsets.all(12),
                      child:Column(
                        children: [
                            Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.selectedLocation,
                                        style:
                                        TextStyle(
                                            fontWeight:FontWeight.bold,
                                          fontSize: 20,
                                          color:Colors.white
                                        ),

                                      ),
                                      Text(
                                      DateFormat("EEE,d LLL").format(DateTime.now()),
                                        style:TextStyle(
                                          fontSize: 15,
                                          color:Colors.white
                                        )
                                      )
                                    ],

                                  ),

                                ),
                                Column(
                                  children: [

                                    IconButton(
                                        onPressed: (){


                                          setState(() {
                                            show_lon_lat = !show_lon_lat;
                                          });

                                        },
                                        icon: const Icon(
                                            Icons.location_on,
                                            color:Colors.white
                                        )),

                                    // Issues to show longitude and latitude
                                    Container(
                                      child: (
                                          (show_lon_lat) ?
                                            Text("${widget
                                                .weatherData['coord']['lon']}",
                                              style: const TextStyle(
                                                  color: Colors.white
                                              ),)
                                              :Text("")


                                      ),
                                    )

                                  ],

                                )



                              ],
                            )
                          ),
                          Container(
                            padding:EdgeInsets.fromLTRB(0, 30, 0, 30),
                            child:Column(
                              children: [
                                Transform.scale(
                                  scale: 1,
                                  child:SvgPicture.asset(
                                    "assets/svg/${widget.weatherData['weather'][0]['icon']}.svg"
                                  ),

                                  ),
                                const SizedBox(height:10),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                      Text(

                                        "${convertToC(widget.weatherData['main']['temp'])}",
                                        style: GoogleFonts.lato(
                                          fontSize:40,
                                          fontWeight:FontWeight.w400,
                                          color:Colors.white

                                        )
                                    ),
                                      Text(
                                          "°C",
                                          style: GoogleFonts.lato(
                                              fontSize:30,
                                              fontWeight:FontWeight.w400,
                                              color:Colors.white

                                          )

                                      )

                                    ]

                                ),
                                Text(
                                  "${widget.weatherData['weather'][0]['description']}",
                                    style: GoogleFonts.lato(
                                    fontSize:25,
                                    fontWeight:FontWeight.w400,
                                    color:Colors.white

                                )

                                ),
                                Text(
                                    "Feels like ${convertToC(widget.weatherData['main']['feels_like'])}°C",
                                    style: GoogleFonts.lato(
                                        fontSize:20,
                                        fontWeight:FontWeight.w400,
                                        color:Colors.white

                                    )

                                ),



                              ],

                            )
                          ),
                        ],
                      )
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                          width:120,
                          height:150,
                          child: Card(
                            color:Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              child:  Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:Colors.white,
                                        borderRadius: BorderRadius.circular(50)

                                      ),
                                      child:const Icon(
                                        FontAwesomeIcons.eye,
                                        color:Colors.lightBlue,
                                      ),
                                    )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Visibility",
                                      style:TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )

                                    ),
                                  ),


                                  // Dynamic data

                                   Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("${widget.weatherData['visibility']/1000} Km",
                                    style:TextStyle(
                                      color:Colors.white,
                                      fontSize: 15
                                    )),
                                  )


                                ],
                              ),

                            )
                          ),
                        ),
                        SizedBox(
                          width:120,
                          height:150,
                          child: Card(
                              color:Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child:  Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:Colors.white,
                                              borderRadius: BorderRadius.circular(50)

                                          ),
                                          child:const Icon(
                                            FontAwesomeIcons.droplet,
                                            color:Colors.lightBlue,
                                          ),
                                        )
                                    ),
                                    const  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Humidity",
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )

                                      ),
                                    ),


                                    // Dynamic data

                                     Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("${widget.weatherData['main']['humidity']} %",
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontSize: 15
                                          )),
                                    )


                                  ],
                                ),

                              )
                          ),
                        ),

                        SizedBox(
                          width:120,
                          height:150,

                          child:Card(
                              color:Colors.lightBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child:  Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color:Colors.white,
                                              borderRadius: BorderRadius.circular(50)

                                          ),
                                          child:const Icon(
                                            FontAwesomeIcons.wind,
                                            color:Colors.lightBlue,
                                          ),
                                        )
                                    ),
                                    const  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                          "Wind Speed",
                                          style:TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )

                                      ),
                                    ),


                                    // Dynamic data

                                     Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("${widget.weatherData['wind']['speed']} km/hr",
                                          style:TextStyle(
                                              color:Colors.white,
                                              fontSize: 15
                                          )),
                                    )


                                  ],
                                ),

                              )
                          )
                        ),

                      ],
                    ),
                  )


                ],
              )
            )

        )
      )
    );
  }
}
