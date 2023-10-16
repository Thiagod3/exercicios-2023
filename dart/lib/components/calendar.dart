// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../dio_client.dart';
import '../model.dart';
import 'activity.dart';

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
                    Text(
                      "Programação",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                        ),
                      ),
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
                          child: Column(
                            children: [
                              Text(
                                "Nov",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                "2023",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  ),
                                ),
                            ],
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


class Cards extends StatelessWidget {

  final String day;

  Cards({required this.day});

  Color getColor(String colorString) {
  try {
    return fromCssColor(colorString);
  } catch (_) {
    return Colors.red;
  }
}

String getHour(String dia) {
  tz.initializeTimeZones();
  DateTime data = DateTime.parse(dia);

  tz.Location timeZone = tz.getLocation('America/Sao_Paulo');
  tz.TZDateTime timeZoneDateTime = tz.TZDateTime.from(data, timeZone);
  return DateFormat('HH:mm').format(timeZoneDateTime);
}

  String getName(List<Map<String, dynamic>> people) {
  try {
    List<String> names = people.map((person) => person['name'] as String).toList();
    return names.join(', ');
  } catch (_) {
    return "";
  }
}



  ActivityModel ? activity;

 Future<ActivityModel> fetchActivity() async {
  var activities = await ActivityApiClient().request();
  var filteredActivities = activities.activity.where((activity) {
    var date = DateTime.parse(activity['start']);
    return date.day.toString() == day;
  }).toList();
  return ActivityModel(activity: filteredActivities); 
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ActivityModel>(
      future: fetchActivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: 300.0,
            height: 100.0,
            child: Image.network('https://chuva.net.br/wp-content/uploads/2023/06/logo-chuva-chapado.png'),
          );
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          activity = snapshot.data;
          return ListView.builder(
            itemCount: activity?.activity?.length ?? 0,
            itemBuilder: (context, index) {
              var item = activity?.activity[index];
              List<Map<String, dynamic>> people = List<Map<String, dynamic>>.from(item['people']);

                return Container(
                  height: 105,
                  margin: EdgeInsets.only(top: 3, left: 3, right: 3),
                  decoration: 
                    BoxDecoration(                
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(82, 0, 0, 0),
                        width: 2
                      ),
                    ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),                          
                          color: getColor('${item['category']['color']}')
                        ),
                        width: 5,
                        margin: EdgeInsets.only(right: 5),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text(
                            '${item['type']['title']['pt-br']} de ${getHour(item['start'])} até ${getHour(item['end'])}',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            ),
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Activity(id: item['id']),
                              fullscreenDialog: true,)
                            ),
                            child:
                              Text(
                                '${item['title']['pt-br']}',
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                          ),
                          Text(
                            getName(people),                            
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: fromCssColor('#757575')
                            ),
                          ),
                        ]),
                      ),
                      Container(
                        width: 72,
                        alignment: Alignment.topRight,
                        child: FavMark(id: item['id'],),
                      )
                    ],
                  ),
                );
            },
          );
        }
      },
    );
  }
}