import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/Article.dart';
import '../config/constants.dart';

class ArticlesProvider with ChangeNotifier {
  List<ArticleModel> _articles = [];

  List<ArticleModel> get list {
    return [..._articles];
  }

  Future<void> fetch() async {
    try {
      final res = await http.get('$BASE_URL/articles');
      print(res);
      final resData = jsonDecode(res.body) as List<dynamic>;
      final List<ArticleModel> loadedArticles = [];
      resData.forEach((item) {
        loadedArticles.add(ArticleModel(
          id: item['_id'],
          title: item['title'],
          image: item['image'], 
        ));
      });
      print(loadedArticles);
      _articles = loadedArticles;
      notifyListeners();
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<ArticleModel> fetchItem(String id) async {
    try {
      final res = await http.get('$BASE_URL/articles/$id');
      final resData = json.decode(res.body);
      return resData;
    } catch (err) {
      throw(err);
    }
  }

}