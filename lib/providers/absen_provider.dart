import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/api_key.dart';
import 'package:tes/get-models/get_asben.dart';

class AbsenProvider {
  static Future<GetAbsen> getAbsen() async {
    Uri url = Uri.parse(ApiKey.absenGetByMonthAndYear);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    final response = await http.get(url, headers: headers);
    final data = json.decode(response.body);
    return GetAbsen.fromJson(data);
  }
}
