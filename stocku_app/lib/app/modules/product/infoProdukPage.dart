import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoProdukPage extends StatelessWidget {
  const InfoProdukPage({super.key});

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
                    padding: EdgeInsets.only(left: 15, right: 15),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset(
                            'lib/assets/icon/back_icon.svg',
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 7, bottom: 17),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 117,
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
                                  color: Color(0xFF319F43),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Tersedia banyak!',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(bottom: 3, top: 3, right: 10, left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xFFEA8D45),
                                      width: 1,
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 0),
                                      )
                                    ]
                                ),
                                child: Text(
                                  'Rumah Tangga',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFFEA8D45)
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Kucing',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Rp5.000,-',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '#K00124',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 11, bottom: 11),
                        padding: EdgeInsets.all(22),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Deskripsi',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 90),
                                Expanded(
                                    child: Text(
                                      'Penghancur barang di rumah, fungsinya peghibur sekaligus pemberi stress',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.right,
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                                Text(
                                  'Sisa Stock',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                    child: Text(
                                      '20 pcs',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.right,
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                                Text(
                                  'Prediksi stok habis',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                    child: Text(
                                      '27/05/2025',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 11,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black
                                      ),
                                      textAlign: TextAlign.right,
                                    )
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(22),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Catatan',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                              'lib/assets/icon/notes_icon.svg',
                              width: 15,
                              height: 15
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: Container(
        height: 82,
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
          child : SvgPicture.asset(
            'lib/assets/icon/hapus_icon.svg',
            width: 30,
            height: 30
          )
        ),
      ),
    );
  }
}
