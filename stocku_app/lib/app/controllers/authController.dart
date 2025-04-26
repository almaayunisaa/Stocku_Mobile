import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final String baseUrl = 'http://localhost:5500/api/auth';
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();


  Future<void> signUp(String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/signUp');

    final body = {
      'username': username,
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        Get.snackbar('Sukses', data['message']);
        Get.toNamed('/signIn');
      } else {
        Get.snackbar('Maaf', data['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> signIn(String username, String password) async {
    GetStorage storage = GetStorage();
    storage.erase();

    final url = Uri.parse('$baseUrl/signIn');
    final penyimpanan = GetStorage();
    dynamic data = penyimpanan.read('riwayat');

    List<String> riwayat = [];
    if (data is List) {
      riwayat = List<String>.from(data);
    } else if (data is String) {
      riwayat = [data];
    }

    final body = {
      'username': username,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data['token'];
        penyimpanan.write('token', token);
        riwayat.add('Berhasil masuk!');
        penyimpanan.write('riwayat', riwayat);

        Get.snackbar('Sukses', 'Login berhasil');
        Get.toNamed('/home');
      } else {
        Get.snackbar('Maaf', data['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> ambilUserData() async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    if (token != null) {
      final parts = token.split('.');
      if (parts.length == 3) {
        try {
          final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          final data = json.decode(payload);
          final String username = data['username'] ?? 'Pengguna';

          penyimpanan.write('username', username);

          final res = await http.get(
            Uri.parse("$baseUrl/getEmail?username=$username"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          );

          final hasil = json.decode(res.body);

          if (res.statusCode == 201) {
            final email = hasil['email'][0]['email'] ?? 'Email tidak ditemukan';

            penyimpanan.write('email', email);
          } else {
            print("Gagal ambil email: ${hasil['message']}");
          }
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }

}
