import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/laporanController.dart';

class TileProdukTidakLaris extends StatelessWidget {
  final laporanController = Get.find<LaporanController>();

  TileProdukTidakLaris({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (laporanController.produkTidakLaris.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Belum ada data produk tidak laris"),
        );
      }

      return ListView.builder(
        itemCount: laporanController.produkTidakLaris.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final produk = laporanController.produkTidakLaris[index];
          final int total = laporanController.produkTidakLaris.length - 1;
          final double factor = index / total;
          final Color circleColor = Color.lerp(Colors.orange.withOpacity(0.2), Colors.orange, factor)!;

          return Container(
            padding: EdgeInsets.only(left: 22, right: 22, top: 6, bottom: 6),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12 ,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5),

                Expanded(
                  child: Text(
                    '${produk.ID.split('-').first}',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                Text(
                  '${produk.stok} pcs',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}