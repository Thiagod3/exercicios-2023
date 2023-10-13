// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

import '../dio_client.dart';
import '../main.dart';
import '../model.dart';
import 'activity.dart';

class Perfil extends StatelessWidget {

  final int id;

  Perfil({required this.id});

Color getColor(String colorString) {
  try {
    return fromCssColor(colorString);
  } catch (_) {
    return Colors.red;
  }
}
  
  ActivityModel ? activity;

Future<List<Map<String, dynamic>>> fetchActivity() async {
    ActivityModel activity = await ActivityApiClient().request();
    List<Map<String, dynamic>> dados = (activity.activity as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();

    int idPessoa = id;

    List<Map<String, dynamic>> dadosFiltrados = dados.where((dado) {
      List<Map<String, dynamic>> people = List<Map<String, dynamic>>.from(dado['people']);
      return people.any((person) => person['id'] == idPessoa);
    }).toList();

    return dadosFiltrados;
  }


 @override
  Widget build(BuildContext context) {
    int idPessoa = id;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchActivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else {
          List<Map<String, dynamic>> dadosFiltrados = snapshot.data ?? [];
          Map<String, dynamic>? person = dadosFiltrados
          .expand((dado) => dado['people'])
          .firstWhere((person) => person['id'] == idPessoa, orElse: () => null);
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
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          if (person != null)
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 10),
                                  width: 100,
                                  height: 100,
                                  child: ClipOval(
                                    child: Image.network(
                                      person['picture'],
                                      scale: 4,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        person['name'],
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        person['institution'],
                                        softWrap: true,
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: TextDecoration.none,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (person != null)
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Text(
                                'Bio:\n ${person['bio']['pt-br']}',
                                softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text('Atividades',
                            softWrap: true,
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontSize: 20,
                                ),                            
                            ),
                            Column(
                              children: dadosFiltrados.map((dado) {
                                return Container(
                                  height: 105,
                                  margin: EdgeInsets.fromLTRB(3, 5, 3, 10),
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
                                          color: getColor('${dado['category']['color']}')
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
                                            '${dado['type']['title']['pt-br']}',
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.black,
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
                                            ),
                                            ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => Activity(id: dado['id']),
                                              fullscreenDialog: true,)
                                            ),
                                            child:
                                              Text(
                                                '${dado['title']['pt-br']}',
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
                              }).toList(),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }
    );    
  }
}