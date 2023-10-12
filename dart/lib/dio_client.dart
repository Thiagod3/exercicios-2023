import 'package:dio/dio.dart';
import 'dart:convert';

import 'model.dart';

class ActivityApiClient {

  Future<ActivityModel> request() async{
    String url = 'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities.json';
    
    final dio = Dio();
    final response = await Dio().get(url);
    final parsedData = jsonDecode(response.toString());
    final activity = ActivityModel.fromJson(parsedData);
    return activity;
  }

}
