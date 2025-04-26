import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/controllers/productController.dart';
import 'package:get/get.dart';

import '../../class/productClass.dart';

class AddProdPage extends StatefulWidget {
  final String kategori;
  const AddProdPage({super.key, required this.kategori});

  @override
  State<AddProdPage> createState() => _AddProdPageState();
}

class _AddProdPageState extends State<AddProdPage> {
  final productController = Get.put(ProductController());
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  int _stok = 0;

  void _tambahStok() {
    setState(() {
      _stok++;
      stockController.text = _stok.toString();
    });
  }

  void _kurangiStok() {
    if (_stok > 0) {
      setState(() {
        _stok--;
        stockController.text = _stok.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.kategori != 'home') {
      kategoriController.text = widget.kategori;
    }
    stockController.text = _stok.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                        spreadRadius: 0,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
                          'Tambah Produk',
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,2),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.1)
                        )
                      ]
                  ),
                  margin: EdgeInsets.only(top: 4),
                  padding: EdgeInsets.fromLTRB(23, 18, 23, 100),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kode',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEB924D),
                        ),
                      ),
                      SizedBox(height: 9),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: kodeController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Kode...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA1A1A1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      Text(
                        'Produk',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEB924D),
                        ),
                      ),
                      SizedBox(height: 9),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: namaController,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Nama Produk...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA1A1A1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      Text(
                        'Kategori',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEB924D),
                        ),
                      ),
                      SizedBox(height: 9),
                      Container(
                        height: 40,
                        child: TextField(
                          controller: kategoriController,
                          readOnly: widget.kategori != 'home',
                          decoration: InputDecoration(
                            hintText: widget.kategori == 'home'
                                ? 'Masukkan Nama Kategori...'
                                : widget.kategori,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA1A1A1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 23),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Harga',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFEB924D),
                                  ),
                                ),
                                SizedBox(height: 9),
                                Container(
                                  height: 40,
                                  child: TextField(
                                    controller: hargaController,
                                    decoration: InputDecoration(
                                      hintText: 'Harga...',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      hintStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFA1A1A1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFEB924D),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFEB924D),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 28),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stok',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFEB924D),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFEB924D),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: _kurangiStok,
                                        icon: SvgPicture.asset(
                                            'lib/assets/icon/kurang_icon.svg',
                                            width: 20,
                                            height: 20
                                        ),
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            '$_stok',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: _tambahStok,
                                        icon: SvgPicture.asset(
                                            'lib/assets/img/add_button.svg',
                                            width: 20,
                                            height: 20
                                        ),
                                        iconSize: 20,
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 23),
                      Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEB924D),
                        ),
                      ),
                      SizedBox(height: 9),
                      Container(
                        height: 330,
                        child: TextField(
                          controller: deskripsiController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Masukkan Deskripsi...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA1A1A1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xFFEB924D),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
      bottomNavigationBar: Container(
        height: 90,
        width: double.infinity,
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
            child : InkWell(
              onTap: () {
                final product = Product(
                  ID: kodeController.text,
                  namaProduk: namaController.text,
                  namaCat: kategoriController.text,
                  harga: int.tryParse(hargaController.text) ?? 0,
                  stok: _stok,
                  deskripsi: deskripsiController.text,
                );

                productController.simpanProduk(product);
                Get.toNamed('/home');
              },
              child: Container(
                  margin: EdgeInsets.only(left: 88, right: 88),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFEB924D),
                  ),
                  child: Center(
                    child: Text(
                      'Tambah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
            )
        ),
      ),
    );
  }
}
