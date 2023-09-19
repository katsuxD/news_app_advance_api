import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../consts/api_const.dart';

import '../model/news_model.dart';

class NewsApiServices {
  //  static Future<List<NewsModel>> getAllNews2() async {
  //   //
  //   // var url = Uri.parse(
  //   //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=');

  //   var uri = Uri.https(BASEURL, "v2/everything", {
  //     "q": "bitcoin",
  //     "pageSize": "5",
  //     "domains": "techcrunch.com"
  //     "apiKey": API_KEY
  //   });
  //   var response = await http.get(
  //     uri
  //   );
  //   // print('Response status: ${response.statusCode}');
  //   // log('Response body: ${response.body}');
  //   Map data = jsonDecode(response.body);
  //   List newsTempList = [];
  //   for (var v in data["articles"]) {
  //     newsTempList.add(v);
  //     log(v.toString());
  //     print(data["articles"].length.toString());
  //   }
  //   return NewsModel.newsFromSnapshot(newsTempList);
  // }
  static Future<List<NewsModel>> getAllNews() async {
    //

    try {

      var uri = Uri.https(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "5",
        "domains": "techcrunch.com",
        "apiKey": API_KEY
      });
      var response = await http.get(
        uri,
        // headers: {"X-Api-key": API_KEY},
      );

      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        log(v.toString());
        print(data["articles"].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
