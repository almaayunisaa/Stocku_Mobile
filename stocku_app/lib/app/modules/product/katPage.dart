import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/controllers/productController.dart';
import 'package:stocku_app/app/modules/product/produkPage.dart';
import 'package:get/get.dart';
import 'package:stocku_app/app/widgets/notifikasiWidget.dart';
import 'package:stocku_app/app/widgets/ubahKategoriWidget.dart';

import '../../widgets/tambahKategoriWidget.dart';

class KategoriPage extends StatefulWidget {
  const KategoriPage({super.key});

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  final productController = Get.put(ProductController());
  late Future<List<Map<String, dynamic>>> futureKategori;

  @override
  void initState() {
    super.initState();
    futureKategori = productController.ambilKategori();
  }

  Future<void> refreshData() async {
    setState(() {
      futureKategori = productController.ambilKategori();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: futureKategori,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final kategoriList = snapshot.data ?? [];

        return RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'DAFTAR KATEGORI',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEA8D45),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: SvgPicture.asset(
                          'lib/assets/icon/addcatshad_icon.svg',
                          width: 25,
                          height: 25,
                        ),
                        onTap: () {
                          final controller = TextEditingController();
                          showTambahKategoriDialog(context, controller, () async {
                            productController.simpanKategori(controller.text);
                            refreshData();
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  ...kategoriList.map((kategori) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProdukPage(namaCat: kategori['namaCategory'])),
                      );
                    },
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: double.infinity,
                      height: 42,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.symmetric(horizontal: 11),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6A261),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            kategori['namaCategory'],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            child: SvgPicture.asset(
                              'lib/assets/icon/edit_icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            onTap: () {
                              final controller = TextEditingController(
                                  text: kategori['namaCategory']);
                              showUbahKategoriDialog(
                                context,
                                controller,
                                kategori['namaCategory'],
                                    () {
                                  productController.ubahKategori(
                                      kategori['namaCategory'],
                                      controller.text);
                                  refreshData();
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                          SizedBox(width: 6),
                          InkWell(
                            child: SvgPicture.asset(
                              'lib/assets/icon/del_icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return NotifikasiWidget(
                                      namaKategori: kategori['namaCategory'],
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

