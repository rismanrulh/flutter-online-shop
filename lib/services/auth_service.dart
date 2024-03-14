// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {
      'Content-Type': 'application/json',
    };
    //mengubah object dart menjadi format json
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      //mengubah format json ke dalam object dart
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);

      user.token = 'Bearer' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    //mengubah object dart menjadi format json
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      //mengubah format json ke dalam object dart
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer' + data['access_token'];

      return user;
    } else {
      throw Exception('Login Gagal!');
    }
  }
}
