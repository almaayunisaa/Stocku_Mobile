import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stocku_app/app/modules/product/editProdPage.dart';

import '../../class/productClass.dart';
import '../../controllers/productController.dart';
import '../../widgets/notifikasiWidget.dart';

class InfoProdukPage extends StatelessWidget {
  final String ID;
  final String namaCat;
  InfoProdukPage({super.key, required this.ID, required this.namaCat});

  final productController = Get.put(ProductController());
  final cekTeksController = TextEditingController();

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
            final Product product = Product.fromJson(snapshot.data!, namaCat);

            productController.prediksiTanggal(ID);

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
                        InkWell(
                          child: Text('Edit',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProdPage(kategori: namaCat, product: product)),
                            );
                          },
                        )
                        
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
                        buildDetailRow('Prediksi stok habis', productController.tanggalPrediksi.value),
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
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              isScrollControlled: true,
                              builder: (context) {
                                return Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 26,
                                              right: 26,
                                              top: 20
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Catatan produk', style:
                                              TextStyle( fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 16)),
                                              IconButton(
                                                icon: Icon(Icons.close_outlined, size: 24),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.15),
                                                blurRadius: 2,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).viewInsets.bottom,
                                              left: 26,
                                              right: 26,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                maxLength: 150,
                                                maxLines: 5,
                                                decoration: InputDecoration(
                                                  hintText: produk['Cek'],
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Color(0xFF514F4F)
                                                  )
                                                ),
                                                controller: cekTeksController,
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Builder(
                                                    builder: (context) {
                                                      final controller = TextEditingController();
                                                      return StatefulBuilder(
                                                        builder: (context, setState) {
                                                          cekTeksController.addListener(() {
                                                            setState(() {});
                                                          });
                                                          return Text(
                                                            '${cekTeksController.text.length}/150',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Container(
                                                    height: 36,
                                                    width: 104,
                                                    child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(0xFFA46B30),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      productController.simpanCek(ID, cekTeksController.text);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Selesai',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                              },
                            );
                          },
                          child: SvgPicture.asset('lib/assets/icon/notes_icon.svg', width: 15, height: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return NotifikasiWidget(
                  onYes: () {
                    productController.hapusProduk(ID);
                  },
                  message: 'Apakah anda yakin menghapus?',
                );
              });
        },
        child: Container(
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
      )

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