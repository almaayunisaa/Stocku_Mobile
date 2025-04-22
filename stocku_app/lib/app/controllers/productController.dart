import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  final String baseUrl = 'http://[IP]:5500/api';

  Future<List<Map<String, dynamic>>> ambilCatatan() async {
    final url = Uri.parse('$baseUrl/product/getReport');
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> datas = data['datas'];
        List<Map<String, dynamic>> listCatatan = [];

        for (var item in datas) {
          if (item['Cek'] != null && item['Cek'].toString() != 'null') {
            listCatatan.add({
              'produk': item['Produk'],
              'cek': item['Cek'],
            });
          }
        }
        return listCatatan;
      } else {
        Get.snackbar('Gagal', data['message']);
        return [];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> ambilKategori() async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/category/getKategori');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List categories = hasil['categories'];
        return List<Map<String, dynamic>>.from(categories);
      } else {
        throw Exception('Gagal mengambil kategori: ${hasil['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }
  void simpanKategori(String namaKategori) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/category/kategori');

    if (namaKategori.isEmpty) {
      Get.snackbar('Peringatan', 'Nama kategori tidak boleh kosong',
          backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'namaKategori': namaKategori}),
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 201) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) riwayat.removeAt(0);
        riwayat.add('Kategori baru: $namaKategori');
        penyimpanan.write('riwayat', riwayat);

      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal menambahkan kategori',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void ubahKategori(String namaKategori, String ubahNamaKat) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/category/kategori/$namaKategori');

    if (ubahNamaKat.isEmpty) {
      Get.snackbar('Peringatan', 'Nama kategori tidak boleh kosong',
          backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
    }

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'editNama': ubahNamaKat}),
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) riwayat.removeAt(0);
        riwayat.add('Kategori diubah: $namaKategori menjadi $ubahNamaKat');
        penyimpanan.write('riwayat', riwayat);
      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal menambahkan kategori',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  void hapusKategori(String namaKategori) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/category/kategori/$namaKategori');

    if (namaKategori.isEmpty) {
      Get.snackbar('Peringatan', 'Nama kategori kosong',
          backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
    }

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) riwayat.removeAt(0);
        riwayat.add('Kategori dihapus: $namaKategori');
        penyimpanan.write('riwayat', riwayat);
      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal menghapus kategori',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> ambilProduk(String namaCat) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/product/$namaCat/getProduct');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List products = hasil['products'];

        return List<Map<String, dynamic>>.from(products);
      } else {
        throw Exception('Gagal mengambil produk: ${hasil['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return [];
    }
  }
  Future<Map<String, dynamic>?> ambilProduk_ID(String ID) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');
    final url = Uri.parse('$baseUrl/product/getProductNama?produk=$ID');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List products = hasil['products'];
        if (products.isNotEmpty) {
          return products[0];
        } else {
          throw Exception('Produk tidak ditemukan');
        }
      } else {
        throw Exception('Gagal mengambil produk: ${hasil['message']}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }

}
