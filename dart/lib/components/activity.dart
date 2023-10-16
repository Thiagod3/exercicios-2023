// ignore_for_file: prefer_const_constructors
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:chuva_dart/main.dart';
import 'package:chuva_dart/model.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../dio_client.dart';
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
  tz.initializeTimeZones();
  DateTime data = DateTime.parse(dia);

  tz.Location timeZone = tz.getLocation('America/Sao_Paulo');
  tz.TZDateTime timeZoneDateTime = tz.TZDateTime.from(data, timeZone);
  return DateFormat('HH:mm').format(timeZoneDateTime);
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
                          child: FavBtn(id: this.id),
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

class FavModel extends ChangeNotifier {
  late SharedPreferences prefs;
  Map<int, bool> _isFavorited = {};

  FavModel() {
    loadPreference();
  }

  bool isFavorited(int id) => _isFavorited[id] ?? false;

  void loadPreference() async {
  prefs = await SharedPreferences.getInstance();
  _isFavorited = Map.fromIterable(
    prefs.getKeys().where((key) => key.startsWith('isFavorited_')),
    key: (key) => int.parse((key as String).split('_')[1]),
    value: (key) => prefs.getBool(key as String) ?? false,
  );
  notifyListeners();
}

  void toggleFavorite(int id) {
  _isFavorited[id] = !(_isFavorited[id] ?? false);
  prefs.setBool('isFavorited_$id', _isFavorited[id]!);
  notifyListeners();
}
}



class FavBtn extends StatelessWidget {
  final int id;

  FavBtn({required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavModel>(
      builder: (context, favModel, child) {
        return Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: ElevatedButton(
            onPressed: () {favModel.toggleFavorite(id);},
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(fromCssColor('#306DC3'))),
            // ...
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  favModel.isFavorited(id) ? Icons.star : Icons.star_border,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  favModel.isFavorited(id) ? 'Remover da sua agenda' : 'Adicionar à sua agenda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}



class FavMark extends StatelessWidget { 
  final int id;

  FavMark({required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavModel>(
      builder: (context, favModel, child) {
        return Container(
          margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Icon(
            favModel.isFavorited(id) ? Icons.bookmark : null,
          ),
        );
      } 
    );      
  }
}