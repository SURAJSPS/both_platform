import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:both_platform/model/pick_sum.dart';

class PicsumUtil {
  static List<Picsum> picsumList = [];

  static Future<List<Picsum>?> fetchHeadLines() async {
    try {
      String url = 'https://picsum.photos/v2/list';
      final response = await http.get(Uri.parse(url));

      var data = jsonDecode(response.body);

      List<dynamic> list =
          data.map((result) => new Picsum.fromJson(result)).toList();
      picsumList.clear();
      for (int b = 0; b < list.length; b++) {
        Picsum headLinetModel = list[b] as Picsum;
        picsumList.add(headLinetModel);
      }
      print(picsumList[0].downloadUrl);
      return picsumList;
    } catch (e) {
      print("Exception________$e");
    }
  }
}
