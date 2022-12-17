import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  late String time;
  String flag;
  String url = 'worldtimeapi.org';
  String endpoint = '';
  late bool isDayTime;

  WorldTime ({ required this.location, required this.flag, required this.endpoint });

  Future<void> getTime() async {

    try{
      Response response = await get(Uri.https(url, 'api/timezone/$endpoint'));
      Map data = jsonDecode(response.body);
      // print(data);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      // print('$datetime - $offset');

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // now = now.add(Duration(hours: 11));
      isDayTime = now.hour > 6 && now.hour <20 ? true : false;
      time = DateFormat.jm().format(now);

    } catch(e){
      if (kDebugMode) {
        print('Caught: $e');
      }
      time = 'Service unavailable';
    }
  }
}