import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../consts/api_const.dart';

import '../model/news_model.dart';

class NewsApiServices {
   static Future<List<NewsModel>> getAllNews2() async {
    //
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=');

    var uri = Uri.https(BASEURL, "v2/everything", {
      "q": "bitcoin",
      "pageSize": "5",
      "domains": "techcrunch.com"

      // "apiKEY": API_KEY
    });
    var response = await http.get(
      uri,
      headers: {"X-Api-key": API_KEY},
    );
    // print('Response status: ${response.statusCode}');
    // log('Response body: ${response.body}');
    Map data = jsonDecode(response.body);
    List newsTempList = [];
    for (var v in data["articles"]) {
      newsTempList.add(v);
      log(v.toString());
      print(data["articles"].length.toString());
    }
    return NewsModel.newsFromSnapshot(newsTempList);
  }
  static Future<List<NewsModel>> getAllNews() async {
    //
  
    try {
        var uri = Uri.parse(
          'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=0b7da8bbb6bb43bea9a387a8ff5d3b4e');
      // var uri = Uri.https(BASEURL, "v2/everything", {
      //   "q": "bitcoin",
      //   "pageSize": "5",
      //   "domains": "techcrunch.com",
      //   // "apiKEY": API_KEY
      // });
      var response = await http.get(
        uri,
        // headers: {"X-Api-key": API_KEY},
      );
      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        // log(v.toString());
        // print(data["articles"].length.toString());
      }
      return NewsModel.newsFromSnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
}
