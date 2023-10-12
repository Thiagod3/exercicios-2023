import 'package:dio/dio.dart';
import 'dart:convert';

import 'model.dart';

class ActivityApiClient {

  Future<ActivityModel> request() async {
    String url = 'https://raw.githubusercontent.com/chuva-inc/exercicios-2023/master/dart/assets/activities';
    
    final dio = Dio();
    final responses = await Future.wait([
      dio.get(url + '.json'),
      dio.get(url + '-1.json'),
    ]);

    final parsedData1 = jsonDecode(responses[0].toString());
    final parsedData2 = jsonDecode(responses[1].toString());

    // Combine the data from the two responses
    parsedData1['data'].addAll(parsedData2['data']);

    final activity = ActivityModel.fromJson(parsedData1);
    return activity;
  }
}
