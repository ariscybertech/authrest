import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static String mainUrl = "https://py.dwed.biz/v1.0/api";
  var loginUrl = '$mainUrl/account/login/';

  final FlutterSecureStorage storage = new FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String username, String password) async {
    Response response = await _dio.post(loginUrl, data: {
      "username": username,
      "password": password,
    });
    return response.data["token"];
  }

}