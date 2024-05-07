import 'package:flutter/material.dart';
import 'package:dice_icons/dice_icons.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor:Colors.red,
          appBar: AppBar(
          title: const Text(
            'Dice...',
          ),
          backgroundColor: Colors.red,
        ),
        body: const DicePage()
      ),
    );
  }
}



class DicePage extends StatefulWidget {
  const DicePage({super.key});



  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber =1,rightDiceNumber = 2;
  void changeDice(bool side){
    setState((){

      if (side == true){
        leftDiceNumber = Random().nextInt(6) + 1;  // to make start from 1 we are adding 1 to random ranges from 0 to 5

      }
      else{
        rightDiceNumber = Random().nextInt(6) + 1;  // to make start from 1 we are adding 1 to random ranges from 0 to 5

      }
    });
  }

  //draw icon

    Map<int,IconData> diceIconMap= {
      1:DiceIcons.dice1,
      2:DiceIcons.dice2,
      3:DiceIcons.dice3,
      4:DiceIcons.dice4,
      5:DiceIcons.dice5,
      6:DiceIcons.dice6,


    };
  @override
  Widget build(BuildContext context) {
    return Row(
            children: <Widget>[
              Expanded(
                child:IconButton(
                  icon:Icon(diceIconMap[leftDiceNumber],size: 180),
                  padding:const EdgeInsets.all(8.0),
                  onPressed: (){
                     changeDice(true);
                  },

                ),
              ),
              Expanded(
                child:IconButton(
                  icon:Icon(diceIconMap[rightDiceNumber],size:180),

                  padding:const EdgeInsets.all(8.0),
                  onPressed: (){
                    changeDice(false);
                  },
                ),
              )



            ],
          );




  }
}



