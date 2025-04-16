import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/tileProdukLaris.dart';

class LapPage extends StatelessWidget {
  const LapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                                Text(
                                  'Rp20.143.000,-',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 25,
                                    color: Color(0xFFEA8D45),
                                  ),
                                ),
                              ],
                            )
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
                            children: <Widget>[
                              TileProdukLaris()
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
                            children: <Widget>[
                              TileProdukLaris()
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
                            children: <Widget>[
                              TileProdukLaris()
                            ],
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
                              bottom: 14,
                              right: 8,
                              child: SvgPicture.asset(
                                'lib/assets/icon/dw_icon.svg',
                                width: 24,
                                height: 24,
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                )

              ],
            ),
          )
      ),
    );
  }
}
