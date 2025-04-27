import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

import '../class/productClass.dart';

class LaporanController extends GetxController {
  var totalPenjualan = ''.obs;
  var produkLaris = <Product>[].obs;
  var produkTidakLaris = <Product>[].obs;
  final String baseUrl = 'http://192.168.1.9:5500/api';

  RxList<String> labelGrafik = <String>[].obs;
  RxList<int> dataGrafik = <int>[].obs;

  void ambilGrafik() async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');
    final url = Uri.parse('$baseUrl/product/getOldData');

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
        List<dynamic> penjualan = hasil['datas'];

        penjualan.sort((a, b) {
          final tglA = DateTime.parse(a['tanggal_habis']);
          final tglB = DateTime.parse(b['tanggal_habis']);
          return tglB.compareTo(tglA);
        });

        final latestTanggal = DateTime.parse(penjualan.first['tanggal_habis']);
        final latestTahun = latestTanggal.year;
        final latestBulan = latestTanggal.month;

        final penjualanTerakhir = penjualan.where((produk) {
          final tanggalProduk = DateTime.parse(produk['tanggal_habis']);
          return tanggalProduk.year == latestTahun && tanggalProduk.month == latestBulan;
        }).toList();

        labelGrafik.clear();
        dataGrafik.clear();

        for (var item in penjualanTerakhir) {
          final idProduk = item['IDProduk'].toString();
          final harga = int.tryParse(item['Harga'].toString()) ?? 0;
          final stok = int.tryParse(item['Stok'].toString()) ?? 0;
          final subtotal = harga * stok;

          labelGrafik.add(idProduk);
          dataGrafik.add(subtotal);
        }

      } else {
        Get.snackbar('Gagal', 'Gagal mengambil grafik penjualan');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void ambilLaporan() async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');
    final url = Uri.parse('$baseUrl/product/getOldData');

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
        List<dynamic> penjualan = hasil['datas'];

        penjualan.sort((a, b) {
          final tglA = DateTime.parse(a['tanggal_habis']);
          final tglB = DateTime.parse(b['tanggal_habis']);
          return tglB.compareTo(tglA);
        });

        final latestTanggal = DateTime.parse(penjualan.first['tanggal_habis']);
        final latestTahun = latestTanggal.year;
        final latestBulan = latestTanggal.month;

        final penjualanTerakhir = penjualan.where((produk) {
          final tanggalProduk = DateTime.parse(produk['tanggal_habis']);
          return tanggalProduk.year == latestTahun && tanggalProduk.month == latestBulan;
        }).toList();

        int total = 0;
        for (var item in penjualanTerakhir) {
          final harga = int.tryParse(item['Harga'].toString()) ?? 0;
          final stok = int.tryParse(item['Stok'].toString()) ?? 0;
          total += harga * stok;
        }

        totalPenjualan.value = 'Rp${total.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')},-';
      } else {
        Get.snackbar(
          'Gagal',
          'Gagal mengambil laporan',
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> ambilProdukLaris() async {
    try {
      final token = GetStorage().read('authToken');
      final res = await http.get(
        Uri.parse('$baseUrl/product/getOldData'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final List rawList = data['datas'];

        rawList.sort((a, b) {
          final tglA = DateTime.parse(a['tanggal_habis']);
          final tglB = DateTime.parse(b['tanggal_habis']);
          return tglB.compareTo(tglA);
        });

        final latestTanggal = DateTime.parse(rawList.first['tanggal_habis']);
        final latestTahun = latestTanggal.year;
        final latestBulan = latestTanggal.month;

        List<Product> hasilFilter = [];

        for (var item in rawList) {
          if (item['ID'] == null) continue;

          final tglProduk = DateTime.tryParse(item['tanggal_habis']);
          if (tglProduk == null) continue;

          if (tglProduk.year == latestTahun && tglProduk.month == latestBulan) {
            final product = Product.fromJson(item, item['kategori'] ?? '');
            hasilFilter.add(product);
          }
        }

        hasilFilter.sort((a, b) => b.stok.compareTo(a.stok));
        produkLaris.value = hasilFilter.take(10).toList();
      } else {
        print('Gagal ambil data produk laris');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> ambilProdukTidakLaris() async {
    try {
      final token = GetStorage().read('authToken');
      final res = await http.get(
        Uri.parse('$baseUrl/product/getOldData'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final List rawList = data['datas'];

        rawList.sort((a, b) {
          final tglA = DateTime.parse(a['tanggal_habis']);
          final tglB = DateTime.parse(b['tanggal_habis']);
          return tglB.compareTo(tglA);
        });

        final latestTanggal = DateTime.parse(rawList.first['tanggal_habis']);
        final latestTahun = latestTanggal.year;
        final latestBulan = latestTanggal.month;

        List<Product> hasilFilter = [];

        for (var item in rawList) {
          final tglProduk = DateTime.tryParse(item['tanggal_habis']);
          if (tglProduk == null) continue;

          if (tglProduk.year == latestTahun && tglProduk.month == latestBulan) {
            final produk = Product.fromJson(item, item['Kategori'] ?? 'Tanpa Kategori');
            hasilFilter.add(produk);
          }
        }

        hasilFilter.sort((a, b) => a.stok.compareTo(b.stok));
        produkTidakLaris.value = hasilFilter.where((p) => p.ID.isNotEmpty).take(10).toList();
      } else {
        print('Gagal ambil data produk tidak laris');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> downloadExcel() async {
    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');
    final url = Uri.parse('$baseUrl/product/getReport');

    try {
      final res = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final hasil = jsonDecode(res.body);

      if (res.statusCode == 200) {
        final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(hasil['datas']);

        final excel = Excel.createExcel();
        final Sheet sheetObject = excel['Sheet1'];

        if (data.isNotEmpty) {
          sheetObject.appendRow(data.first.keys.toList());

          for (final row in data) {
            sheetObject.appendRow(row.values.toList());
          }
        }

        final directory = Directory('/storage/emulated/0/Download');
        final path = '${directory.path}/laporan.xlsx';

        final fileBytes = excel.encode();
        final file = File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes!);

        Get.snackbar('Sukses', 'File disimpan di: Folder Download',
            backgroundColor: Color(0xFFEA8D45), colorText: Colors.white);
      } else {
        Get.snackbar('Gagal', 'Gagal mengunduh laporan');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void kirimStokKeOldProd() async {
    final tanggalNow = DateTime.now();
    final day = tanggalNow.day.toString().padLeft(2, '0');
    final month = tanggalNow.month.toString().padLeft(2, '0');
    final year = tanggalNow.year.toString().substring(2, 4);

    final box = GetStorage('stokBulanIni');
    final List<dynamic> dataStok = box.read('dataStok') ?? [];

    final penyimpanan = GetStorage();
    final token = penyimpanan.read('token');

    for (var item in dataStok) {
      final idProd = item['id'];
      final stok = item['stok'];
      final harga = item['harga'];

      final idGabung = '$idProd$day$month$year';

      final url = Uri.parse('$baseUrl/product/setOldProd'
          '?id=$idGabung'
          '&stok=$stok'
          '&harga=$harga'
          '&id_prod=$idProd'
          '&tgl_hbs=${tanggalNow.toIso8601String()}');

      try {
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        final hasil = jsonDecode(response.body);

        if (response.statusCode == 200) {
          print('Sukses kirim $idProd: ${hasil['message']}');
        } else {
          print('Gagal kirim $idProd: ${hasil['message']}');
        }
      } catch (e) {
        print('Error kirim $idProd: $e');
      }
    }
  }
}
