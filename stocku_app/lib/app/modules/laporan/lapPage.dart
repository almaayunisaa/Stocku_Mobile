import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stocku_app/app/widgets/tileCatatan.dart';
import 'package:stocku_app/app/widgets/tileProdukTidakLaris.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/laporanController.dart';
import '../../widgets/tileProdukLaris.dart';

class LapPage extends StatefulWidget {
  const LapPage({super.key});

  @override
  State<LapPage> createState() => _LapPageState();
}

class _LapPageState extends State<LapPage> {
  final laporanController = Get.put(LaporanController());

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
    laporanController.ambilGrafik();
    laporanController.ambilLaporan();
    laporanController.ambilProdukLaris();
    laporanController.ambilProdukTidakLaris();
  }

  Future<void> refreshData() async {
    laporanController.ambilGrafik();
    laporanController.ambilLaporan();
    laporanController.ambilProdukLaris();
    laporanController.ambilProdukTidakLaris();
  }


  Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) {
      return true;
    }

    if (await Permission.manageExternalStorage.isGranted) {
      return true;
    }

    final status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 110, left: 24, right: 24, bottom: 29),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Penjualan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Obx(() => Text(
                              laporanController.totalPenjualan.value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                color: Color(0xFFEA8D45),
                              ),
                            )),
                            SizedBox(height: 16),
                            Text(
                              'Grafik Penjualan Bulan Lalu',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            SizedBox(
                              height: 200,
                              child: Obx(() {
                                if (laporanController.labelGrafik.isEmpty) {
                                  return Center(child: Text('Belum ada data'));
                                }
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: laporanController.dataGrafik.length * 50, // Lebar per bar + spacing
                                    child: BarChart(
                                      BarChartData(
                                        alignment: BarChartAlignment.spaceAround,
                                        maxY: (laporanController.dataGrafik.reduce((a, b) => a > b ? a : b).toDouble()) + 1000,
                                        barTouchData: BarTouchData(enabled: false),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                String label;
                                                if (value >= 1000000) {
                                                  label = '${(value / 1000000).toStringAsFixed(1)}M';
                                                } else if (value >= 1000) {
                                                  label = '${(value / 1000).toStringAsFixed(0)}k';
                                                } else {
                                                  label = value.toInt().toString();
                                                }
                                                return Text(
                                                  label,
                                                  style: TextStyle(fontSize: 10),
                                                );
                                              },
                                              reservedSize: 32,
                                            ),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (double value, TitleMeta meta) {
                                                final index = value.toInt();
                                                if (index >= 0 && index < laporanController.labelGrafik.length) {
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: Text(
                                                      laporanController.labelGrafik[index],
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                  );
                                                } else {
                                                  return Text('');
                                                }
                                              },
                                              reservedSize: 42,
                                            ),
                                          ),
                                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        barGroups: List.generate(
                                          laporanController.dataGrafik.length,
                                              (index) => BarChartGroupData(
                                            x: index,
                                            barRods: [
                                              BarChartRodData(
                                                toY: laporanController.dataGrafik[index].toDouble(),
                                                color: Color(0xFFEA8D45),
                                                width: 20,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ],
                                            barsSpace: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ]
                        ),
                        child: ExpansionTile(
                          leading: SvgPicture.asset(
                            'lib/assets/icon/up_icon.svg',
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            'Produk Paling Laris',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          children: <Widget>[TileProdukLaris()],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ]
                        ),
                        child: ExpansionTile(
                          leading: SvgPicture.asset(
                            'lib/assets/icon/down_icon.svg',
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            'Produk Tidak Laris',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          children: <Widget>[TileProdukTidakLaris()],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ]
                        ),
                        child: ExpansionTile(
                          leading: SvgPicture.asset(
                            'lib/assets/icon/catatan_icon.svg',
                            width: 20,
                            height: 20,
                          ),
                          title: Text(
                            'Catatan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                          children: <Widget>[TileCatatan()],
                        ),
                      ),
                    ],
                  ),
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
                          bottom: 16,
                          child: Text(
                            'Laporan',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 8,
                            child: IconButton(
                              icon: SvgPicture.asset(
                                'lib/assets/icon/dw_icon.svg',
                                width: 24,
                                height: 24,
                              ),
                              onPressed: () async {
                                await requestStoragePermission();
                                await Permission.manageExternalStorage.request();
                                await laporanController.downloadExcel();
                              },
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
            ),
          ),
        ),
      ),
    );
  }
}
