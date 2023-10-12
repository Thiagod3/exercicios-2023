// ignore_for_file: prefer_const_constructors

import 'package:chuva_dart/components/cards.dart';
import 'package:chuva_dart/components/homepage.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:dio/dio.dart';

import 'package:chuva_dart/model.dart';
import 'dio_client.dart';
import 'components/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
              Homepage(),
              Expanded(
                child: Cards(),
              ),
          ]),
        ),
      ),
    );
  }
}