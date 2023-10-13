// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../model.dart';
import '../dio_client.dart';
import 'activity.dart';

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
                            '${item['type']['title']['pt-br']}',
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
                        child: Icon(
                          Icons.bookmark,
                          size: 30, 
                          color: fromCssColor('#7C90AC'),          
                        ),
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
