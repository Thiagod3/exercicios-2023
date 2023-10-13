// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

class Calendar extends StatelessWidget{

final Function(String) onDateSelected;

Calendar({required this.onDateSelected});

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
            children: [
              Container(
                color: fromCssColor('#456189'),
                width: double.infinity,
                child: Column(
                  children: [
                    ElevatedButton.icon(onPressed: (){},
                     icon: Container(
                        decoration: BoxDecoration(              
                          color: fromCssColor('#306DC3'),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black,
                        ),
                      ),
                      label: Text(
                        "Exibindo todas atividades",
                        style: TextStyle( color: Colors.black),
                      ),
                      ),            
                  ],
                ),
              ),
              Row(
                    children: [
                      Container(
                        width: 60,
                        height: 62,
                        child: TextButton(
                          onPressed: (){},
                          child: Text(
                            "Nov 2023",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              ),
                            ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        child: TextButton(
                          onPressed: (){
                            onDateSelected('26');
                          },
                          child: Text("26",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          style: ButtonStyle(                      
                            backgroundColor:  MaterialStateProperty.all(fromCssColor('#306DC3')),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        child: TextButton(
                          onPressed: (){
                            onDateSelected('27');
                          },
                          child: Text("27",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          style: ButtonStyle(                      
                            backgroundColor:  MaterialStateProperty.all(fromCssColor('#306DC3')),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        child: TextButton(
                          onPressed: (){
                            onDateSelected('28');
                          },
                          child: Text("28",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          style: ButtonStyle(                      
                            backgroundColor:  MaterialStateProperty.all(fromCssColor('#306DC3')),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        child: TextButton(
                          onPressed: (){
                            onDateSelected('29');
                          },
                          child: Text("29",
                            style: TextStyle(
                              color: Colors.white
                            ),),
                          style: ButtonStyle(                      
                            backgroundColor:  MaterialStateProperty.all(fromCssColor('#306DC3')),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(top: 2),
                        child: TextButton(
                          onPressed: (){
                            onDateSelected('30');
                          },
                          child: Text(
                            "30",
                            style: TextStyle(
                              color: Colors.white
                            ),
                            ),
                          style: ButtonStyle(                      
                            backgroundColor:  MaterialStateProperty.all(fromCssColor('#306DC3')),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                    ],
                  ),
            ],
          ),
    );
  }
}