// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class FavBtn extends StatefulWidget {
  @override
  _FavBtnState createState() => _FavBtnState();
}

class _FavBtnState extends State<FavBtn> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: ElevatedButton(
        onPressed: () {toggleFavorite();},
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 5, 0, 5)),
            backgroundColor:  MaterialStateProperty.all(fromCssColor('#007BE5')),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isFavorited ? Icons.star_border : Icons.star,
                color: Colors.white,
                size: 24,
              ),
              Text(
                isFavorited ? 'Remover da sua agenda' : 'Adicionar à sua agenda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              )
        ],
         ),
      ),
    );       
  }
}