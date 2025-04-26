import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stocku_app/app/controllers/productController.dart';
import 'package:stocku_app/app/modules/product/addProdPage.dart';
import 'package:stocku_app/app/modules/product/katPage.dart';
import 'package:stocku_app/app/widgets/buttonHomeWidget.dart';
import 'package:get/get.dart';

import '../../widgets/tambahKategoriWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final penyimpanan = GetStorage();
  final prodController = Get.put(ProductController());

  List<String> riwayat = [];
  late Future<List<Map<String, dynamic>>> futureCatatan;

  @override
  void initState() {
    super.initState();
    ambilRiwayat();
    futureCatatan = prodController.ambilCatatan();
  }

  void ambilRiwayat() {
    dynamic data = penyimpanan.read('riwayat');
    if (data is List) {
      riwayat = List<String>.from(data);
    } else if (data is String) {
      riwayat = [data];
    }
  }

  Future<void> _refresh() async {
    setState(() {
      ambilRiwayat();
      futureCatatan = prodController.ambilCatatan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: ButtonHomeWidget(
                        assetPath: 'lib/assets/img/add_button.svg',
                        labelButton: 'Tambah Produk',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddProdPage(kategori: 'home')),
                        );
                      },
                    ),
                    const SizedBox(width: 40),
                    InkWell(
                      child: ButtonHomeWidget(
                        assetPath: 'lib/assets/img/addcat_button.svg',
                        labelButton: 'Tambah Kategori',
                      ),
                      onTap: () {
                        final controller = TextEditingController();
                        showTambahKategoriDialog(context, controller, () async {
                          productController.simpanKategori(controller.text);
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),

              // Riwayat Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF6AB70).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 53,
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            SvgPicture.asset('lib/assets/icon/history_icon.svg'),
                            const SizedBox(width: 7),
                            const Text(
                              'Riwayat',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFEA8D45),
                              ),
                            )
                          ],
                        ),
                      ),
                      ...riwayat.map((item) => Padding(
                        padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6AB70),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 14),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF6AB70).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 53,
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            SvgPicture.asset(
                              'lib/assets/icon/catatan_icon.svg',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 7),
                            const Text(
                              'Catatan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFEA8D45),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: futureCatatan,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Text('Error: ${snapshot.error}')),
                            );
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: Center(child: Text('Tidak ada catatan yang ditemukan.')),
                            );
                          }

                          final data = snapshot.data!;
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.4,
                            ),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final item = data[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 6, bottom: 6),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(right: 10, top: 4),
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFEA8D45),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['produk'] ?? 'Produk tidak ditemukan',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                item['cek'] ?? 'Tidak ada catatan',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
