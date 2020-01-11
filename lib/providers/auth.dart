import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/User.dart';
import '../config/constants.dart';

class Auth with ChangeNotifier {
  String _token;
  User _user;

  String get token {
    return _token;
  }

  User get user {
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
        '${BASE_URL}/auth/session',
         headers: {
          'Authorization': 'Bearer ${token}'
        }
      );
      final resData = json.decode(res.body);
      _token = token;
      _user = resData['user'];
      notifyListeners();
    } catch(err) {
      await clearToken();
      throw err;
    }
  }
  
  Future<void> register(String name, String email, String password) async {
    try {
      final res = await http.post(
        '${BASE_URL}/auth/register', 
        body: json.encode(
          {
            'name': name,
            'email': email,
            'password': password
          }
        )
      );
      final resData = json.decode(res.body);
      _token = resData['token'];
      _user = resData['user'];
      notifyListeners();
      saveToken(_token);
    } catch (err) {
      throw err;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final res = await http.post(
       '${BASE_URL}/auth/login', 
        body: json.encode(
          {
            'email': email,
            'password': password
          }
        )
      );
      final resData = json.decode(res.body);
      _token = resData['token'];
      _user = resData['user'];
      notifyListeners();
      saveToken(_token);
    } catch (err) {
      throw err;
    }
  }

  Future<void> logout() async {
    if (_token == null) return;
    try {
      await http.get(
        '${BASE_URL}/auth/logout', 
        headers: {
          'Authorization': 'Bearer ${token}'
        }
      );
      await clearToken();
      _user = null;
      _token = null;
    } catch (err) {
      throw err;
    }
  }

}