import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          title:const Text('Hotel Rooms')
        ),
        body:Column(

          children: [

            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child: SizedBox(
            //     height: 300, // Set the fixed height
            //     width: double.infinity, // Set the width to match the screen width
            //     child: Scrollbar(
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: 3,
            //         itemBuilder: (context, index) => const FavoriteRooms(
            //           title: 'Favorite Room',
            //           price: 2800.0, // Example price value, replace with actual value
            //           size: '2 bed, 2 bath, 1400 sqft', // Example size value, replace with actual value
            //           sideCardImage: 'https://source.unsplash.com/random/200x200?room', // Example image URL, replace with actual value
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child:Scrollbar(

                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (c,i)=> const _SampleCard(heading: " 2800 per month", subheading: "2 bed, 2 bath, 1400 sqft",cardImage:'https://source.unsplash.com/random/800x600?house',supportingText: 'Beautiful home to rent, recently refurbished with modern appliances...'),

                    ),
                  )
              ),
            )
          ],
        )
        // Include FavoriteRooms widget here



        )


      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // TRY THIS: Try running your application with "flutter run". You'll see
      //   // the application has a purple toolbar. Then, without quitting the app,
      //   // try changing the seedColor in the colorScheme below to Colors.green
      //   // and then invoke "hot reload" (save your changes or press the "hot
      //   // reload" button in a Flutter-supported IDE, or press "r" if you used
      //   // the command line to start the app).
      //   //
      //   // Notice that the counter didn't reset back to zero; the application
      //   // state is not lost during the reload. To reset the state, use hot
      //   // restart instead.
      //   //
      //   // This works for code too, not just values: Most code changes can be
      //   // tested with just a hot reload.
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class _SampleCard extends StatelessWidget{
  const _SampleCard({
    super.key,
    required this.heading,
    required this.subheading,
    required this.cardImage,
    required this.supportingText,
});

  final String heading;
  final String subheading;
  final String cardImage;
  final String supportingText;
  @override
  Widget build(BuildContext context){
    return Card(
    elevation:4.0,
      child:Column(
        children: [
          ListTile(
            title:Text(heading),
            subtitle: Text(subheading),
            trailing: Icon(Icons.favorite_outline),
          ),
          Container(
            height:300.0,
            child:Ink.image(image:NetworkImage(cardImage),fit:BoxFit.cover)
          ),
          Container(
            padding:EdgeInsets.all(16.0),

           child:Text(supportingText)
          ),
          ButtonBar(
            children: [
              TextButton(
                child:const Text('Contact Agent'),
                onPressed: (){/*...*/},
              ),
              TextButton(
                child:const Text('Learn More'),
                onPressed: (){/*...*/},
              ),
            ],
          )

        ],
      )
    );
  }
}

class FavoriteRooms extends StatelessWidget{
  const FavoriteRooms({
    super.key,
    required this.title,
    required this.price,
    required this.size,
    required this.sideCardImage

});
  final String title;
  final double price;
  final String size;
  final String sideCardImage;

  @override
  Widget build(BuildContext context){
    return Card(
      child:Column(
        children: [
          Container(
              height:200.0,
              width:100.0,
              child:Ink.image(image:NetworkImage(sideCardImage),fit:BoxFit.fill)
          ),
          Container(
            padding: EdgeInsets.all(6),
            child:Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),


          ),
          ListTile(
            title:Text(title),
            subtitle: const Text(
              "afasf"
            ),
          ),
        ],
      )

    );
  }
}
