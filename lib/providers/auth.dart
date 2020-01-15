import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../config/constants.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  UserModel _user;

  String get token {
    return _token;
  }

  UserModel get user {
    return _user;
  }

  bool get isAuth {
    return token != null;
  }

  void saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('token')) return false;
    final token = prefs.getString('token');
    try {
      final res = await http.get(
        '$BASE_URL/auth/me',
         headers: {
          'Authorization': 'Bearer $token'
        }
      );
     final resData = jsonDecode(res.body);
      _token = token;
      _user = UserModel(
        resData['_id'],
        resData['name'],
        resData['email'],
        resData['avatar']
      );
      notifyListeners();
    } catch(err) {
      print(err);
      await clearToken();
      throw err;
    }
  }
  
  Future<void> register(String name, String email, String password, String password_confirm) async {
    try {
      final body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirm': password_confirm
      });
      final res = await http.post(
        '$BASE_URL/auth/register', 
        body: body,
        headers: {'Content-type': 'application/json'}
      );
      final resData = jsonDecode(res.body);
      _token = resData['token'];
      _user = UserModel(
        resData['user']['_id'],
        resData['user']['name'],
        resData['user']['email'],
        resData['user']['avatar']
      );
      notifyListeners();
      saveToken(_token);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final res = await http.post(
       '$BASE_URL/auth/login', 
        body: jsonEncode(
          {
            'email': email,
            'password': password
          }
        ),
        headers: {'Content-type': 'application/json'}
      );
      final resData = jsonDecode(res.body);
      _token = resData['token'];
      _user = UserModel(
        resData['user']['_id'],
        resData['user']['name'],
        resData['user']['email'],
        resData['user']['avatar']
      );
      notifyListeners();
      saveToken(_token);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> logout() async {
    if (_token == null) return;
    try {
      await http.get(
        '$BASE_URL/auth/logout', 
        headers: {
          'Authorization': 'Bearer $token'
        }
      );
      await clearToken();
      _user = null;
      _token = null;
    } catch (err) {
      print(err);
      throw err;
    }
  }

}