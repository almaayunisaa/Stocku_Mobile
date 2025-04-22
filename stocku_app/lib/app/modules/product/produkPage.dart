import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stocku_app/app/controllers/productController.dart';

import 'package:stocku_app/app/modules/product/infoProdukPage.dart';
import 'package:stocku_app/app/modules/product/addProdPage.dart';


class ProdukPage extends StatelessWidget {
  final productController = Get.put(ProductController());
  final String namaCat;
  ProdukPage({super.key, required this.namaCat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 90,
              width: double.infinity,
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    bottom: 4,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: SvgPicture.asset(
                        'lib/assets/icon/back_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Text(
                      namaCat,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 23, vertical: 16),
                child: Column(
                  children: [
                    // Search Bar
                    Container(
                      width: double.infinity,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.01),
                            blurRadius: 3,
                            spreadRadius: 0.5,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                      child: SearchBar(
                        hintText: 'Cari produk',
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(
                          TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Color(0xFFB9B9B9)),
                        ),
                        trailing: [
                          IconButton(
                            icon: SvgPicture.asset(
                              'lib/assets/icon/search_icon.svg',
                              width: 16,
                              height: 16,
                            ),
                            onPressed: () {
                              print('Button Clicked!');
                            },
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: productController.ambilProduk(namaCat),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text('Tidak ada produk ditemukan.'));
                          }

                          final produkList = snapshot.data!;
                          return ListView.builder(
                            itemCount: produkList.length,
                            itemBuilder: (context, index) {
                              final produk = produkList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => InfoProdukPage(namaCat: namaCat,ID: produk['ID'])),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                        offset: Offset(0, 1),
                                      )
                                    ],
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
                                            produk['Produk'] ?? 'Nama tidak ada',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'Rp${produk['harga'] ?? '0'},-',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 24),
                                          Text(
                                            '#${produk['ID'] ?? 'kode'}',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${produk['Stok'] ?? 0} pcs',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProdPage()),
          );
        },
        child: SvgPicture.asset(
          'lib/assets/img/add_button.svg',
          width: 70,
          height: 70,
        ),
      ),
    );
  }
}
