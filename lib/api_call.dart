import 'dart:convert';

import 'package:http/http.dart' as http;

List<String> cities = [];

Future? fetchWeather(Uri uri) async {
  final responseList = await http.get(uri);
  List fetchedData = jsonDecode(responseList.body);
  for (int i = 0; i < fetchedData.length; i++) {
    if (!cities.contains(fetchedData[i]["location"])) {
      cities.add(fetchedData[i]["location"]);
    }
  }
  return jsonDecode(responseList.body);
}
