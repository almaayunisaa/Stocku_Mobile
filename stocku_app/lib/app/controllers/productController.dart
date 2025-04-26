import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../class/productClass.dart';

class ProductController extends GetxController {
  final String baseUrl = 'http://localhost:5500/api';
  var tanggalPrediksi = ''.obs;

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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
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
      print(e.toString());
      return null;
    }
  }
  void simpanProduk(Product p) async   {
    final penyimpanan = GetStorage();
    final namaCat = p.namaCat;
    final token = penyimpanan.read('token');
    final namaProd = p.namaProduk;

    final url = Uri.parse('$baseUrl/product/$namaCat/tambahProduk');

    if (namaCat.isEmpty) {
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
        body: jsonEncode({
          'namaProduk': p.namaProduk,
          'id': p.ID,
          'stok': p.stok,
          'harga': p.harga,
          'deskripsi': p.deskripsi,
        }),

      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 201) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) riwayat.removeAt(0);
        riwayat.add('Produk baru: $namaProd di kategori $namaCat');
        penyimpanan.write('riwayat', riwayat);

      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal menambahkan produk',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void ubahProduk(Product p, String ID) async {
    final penyimpanan = GetStorage();
    final namaCat = p.namaCat;
    final namaProduk = p.namaProduk;
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/product/editProduk/$ID');

    if (namaCat.isEmpty) {
      Get.snackbar('Peringatan', 'Nama kategori tidak boleh kosong',
          backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
    }

    try {
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'namaProduk': p.namaProduk,
          'stok': p.stok,
          'harga': p.harga,
          'deskripsi': p.deskripsi,
        }),
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) riwayat.removeAt(0);
        riwayat.add('Produk $namaProduk berhasil diubah');
        penyimpanan.write('riwayat', riwayat);
        Get.toNamed('/home');

      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal mengubah produk',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      print(e.toString());
    }
  }
  void hapusProduk(String ID) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    final url = Uri.parse('$baseUrl/product/hapusProduk/$ID');

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
        riwayat.add('Produk $ID berhasil dihapus');
        penyimpanan.write('riwayat', riwayat);
        Get.toNamed('/home');

      } else {
        Get.snackbar('Gagal', hasil['message'] ?? 'Gagal menghapus produk',
            backgroundColor: Color(0xFFEA8D45), colorText: Color(0xFFFFFFFF));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> bisaPrediksi(String id) async {
    return true;
  }
  Future<void> prediksiTanggal(String id) async {
    bool bisa = await bisaPrediksi(id);
    if (bisa) {
      final penyimpanan = GetStorage();
      final token = penyimpanan.read('token');

      try {
        final response = await http.patch(
          Uri.parse('$baseUrl/product/editPrediksi/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        final hasil = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final hariPrediksi = hasil['hari'];
          final tanggalSekarang = DateTime.now();
          final tanggalHasil = tanggalSekarang.add(Duration(days: hariPrediksi));

          tanggalPrediksi.value = '${tanggalHasil.day}-${tanggalHasil.month}-${tanggalHasil.year}';
        } else {
          tanggalPrediksi.value = 'Belum bisa diprediksi';
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      tanggalPrediksi.value = 'Belum bisa diprediksi';
    }
  }
  Future<void> simpanCek(String id, String cek) async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/product/editCek/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'cek': cek}),
      );

      final hasil = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<String> riwayat = penyimpanan.read('riwayat')?.cast<String>() ?? [];
        if (riwayat.length >= 6) {
          riwayat.removeAt(0);
        }
        riwayat.add('Komentar baru: $id');
        penyimpanan.write('riwayat', riwayat);

        Get.snackbar('Sukses', 'Catatan berhasil disimpan');
      } else {
        Get.snackbar('Gagal', hasil['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
