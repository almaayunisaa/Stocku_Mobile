import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stocku_app/app/controllers/productController.dart';

class TileCatatan extends StatelessWidget {
  final productController = Get.find<ProductController>();

  TileCatatan({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: productController.ambilCatatan(),
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // Handle error state
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        // Handle empty data
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: Text('Tidak ada catatan yang ditemukan.')),
          );
        }

        // Display data in the exact format from the second example
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
                        Expanded(
                          child: Column(
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
    );
  }
}