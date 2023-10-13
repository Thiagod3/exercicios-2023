// ignore_for_file: prefer_const_constructors
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:chuva_dart/main.dart';
import 'package:chuva_dart/model.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';


import '../dio_client.dart';
import 'fav-btn.dart';
import 'perfil.dart';

class Activity extends StatelessWidget{

  final int id;

  Activity({required this.id});
  ActivityModel ? activity;

  Color getColor(String colorString) {
  try {
    return fromCssColor(colorString);
  } catch (_) {
    return Colors.red;
  }
}

  String getWeekDay(String dia){
  initializeDateFormatting('pt_BR', null);
  DateTime data = DateTime.parse(dia);
  String dayOfWeek = DateFormat('EEEE', 'pt_BR').format(data);

  dayOfWeek = '${dayOfWeek[0].toUpperCase()}${dayOfWeek.substring(1)}';

  return dayOfWeek;
}

String getHour(String dia) {
  DateTime data = DateTime.parse(dia);
  return DateFormat('HH:mm', 'pt-BR').format(data.toLocal());
}

String getLoc(List<Map<String, dynamic>> locations) {
  try {
    List<String> loc = locations.map((location) => location['title']['pt-br'] as String).toList();
    return loc.join(', ');
  } catch (_) {
    return "";
  }
}

List<Map<String, dynamic>> getPeopleDetails(List<Map<String, dynamic>> people) {
  try {
    List<Map<String, dynamic>> details = people.map((person) {
      String role = person['role']['label']['pt-br'];
      String name = person['name'];
      String picture = person['picture'];
      int idPerfil = person['id'];
      return {'role': role, 'name': name, 'picture': picture, 'id': idPerfil};
    }).toList();
    return details;
  } catch (_) {
    return [];
  }
}



  Future<ActivityModel> fetchActivity() async {
  var activities = await ActivityApiClient().request();
  var filteredActivities = activities.activity.where((activity) {
    var idJson = (activity['id']);
    return idJson == id;
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
              List<Map<String, dynamic>> locations = List<Map<String, dynamic>>.from(item['locations']);
               List<Map<String, dynamic>> people = List<Map<String, dynamic>>.from(item['people']);
              List<Map<String, dynamic>> peopleDetails = getPeopleDetails(people);
              return Column(
                children: [
                  AppBar(
                      backgroundColor: Color.fromARGB(255, 69, 97, 137),
                      leading: IconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChuvaDart(),
                          fullscreenDialog: true,
                          )
                        ),
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
                  Container(
                    color: fromCssColor('#FFFFFF'),
                    height: 700,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          color: getColor('${item['category']['color']}'),
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            '${item['category']['title']['pt-br']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                            ),
                        ),
                        Text('${item['title']['pt-br']}', 
                        textAlign: TextAlign.center,                       
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                              children: [
                                Icon(Icons.access_time, color: fromCssColor('#306DC3'),),
                                Text(
                                  ' ${getWeekDay(item['start'])} ${getHour(item['start'])}h - ${getHour(item['end'])}h',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                  )
                              ],
                            ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(                          
                              children: [
                                Icon(Icons.place, color: fromCssColor('#306DC3'),),
                                Text(' ${getLoc(locations)}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                )
                              ],
                            ),
                        ),
                        Container(
                          child: FavBtn(),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                child:
                                Text(
                                  '${item['description']['pt-br']}', 
                                  softWrap: true,
                                  maxLines: 15,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,                            
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: peopleDetails.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 15),
                                              alignment: Alignment.centerLeft,
                                              child:
                                              Text(
                                                  '${peopleDetails[index]['role']}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    decoration: TextDecoration.none,
                                                  ),
                                                ),
                                            ),

                                            Container(
                                              child: 
                                                Row(
                                                  children: [
                                                    Container(
                                                    margin: EdgeInsets.only(left: 15),                                                      
                                                      width: 50,
                                                      height: 50,
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          '${peopleDetails[index]['picture']}',
                                                          scale: 8,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () => Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) => Perfil(id: peopleDetails[index]['id']),
                                                        fullscreenDialog: true,)
                                                      ),
                                                      child: Text(
                                                      ' ${peopleDetails[index]['name']}',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                    )
                                                  ],
                                                ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )

                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}