// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';

import 'components/cards.dart';
import 'components/homepage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String daySelected = '26';

  void onDateSelected(String day) {
    setState(() {
      daySelected = day;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Aplicativo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 69, 97, 137),
          leading: IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 36,
            )
          ),
          title: Text(
            'Chuva 💜 Flutter',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),

        body: Center(
          child: Column(children: <Widget>[            
              Homepage(onDateSelected: onDateSelected),   
              Expanded(
                child: Cards(day: daySelected),
              ),         
          ]),
        ),
      ),
    );
  }
}