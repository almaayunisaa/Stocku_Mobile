import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/productController.dart';

class InfoProdukPage extends StatelessWidget {
  final String ID;
  final String namaCat;
  InfoProdukPage({super.key, required this.ID, required this.namaCat});

  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: productController.ambilProduk_ID(ID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('Produk tidak ditemukan'));
            }

            final produk = snapshot.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Header section
                  Container(
                    height: 90,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFFEA8D45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: SvgPicture.asset('lib/assets/icon/back_icon.svg'),
                        ),
                        Text('Edit',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                      ],
                    ),
                  ),

                  // Product info section
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 17),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: (int.tryParse(produk['Stok'].toString()) ?? 0) < 10
                                    ? Colors.red
                                    : Color(0xFF319F43),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              (int.tryParse(produk['Stok'].toString()) ?? 0) < 10
                                  ? 'Yah, tinggal sedikit!'
                                  : 'Tersedia banyak!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFEA8D45)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                namaCat,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xFFEA8D45)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                produk['Produk'] ?? 'Nama Produk',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Text(
                              'Rp${produk['harga']?.toString() ?? '0'},-',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '#${produk['ID'] ?? ''}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Details section
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 11),
                    padding: EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        buildDetailRow('Deskripsi', produk['deskripsi'] ?? '-'),
                        SizedBox(height: 14),
                        buildDetailRow('Sisa Stock', '${produk['Stok']?.toString() ?? '0'} pcs'),
                        SizedBox(height: 14),
                        buildDetailRow('Prediksi stok habis', produk['Prediksi'] ?? '-'),
                      ],
                    ),
                  ),

                  // Notes section
                  Container(
                    padding: EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text('Catatan',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                        Spacer(),
                        SvgPicture.asset('lib/assets/icon/notes_icon.svg', width: 15, height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 82,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.13),
              offset: Offset(0, -3),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset('lib/assets/icon/hapus_icon.svg', width: 30, height: 30),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Text(label,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        Spacer(),
        Expanded(
          child: Text(value,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              textAlign: TextAlign.right),
        )
      ],
    );
  }
}