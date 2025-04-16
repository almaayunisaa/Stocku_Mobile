import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/product/addProdPage.dart';
import 'package:stocku_app/app/widgets/buttonHomeWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: ButtonHomeWidget(
                    assetPath: 'lib/assets/img/add_button.svg',
                    labelButton: 'Tambah Produk',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProdPage()),
                    );
                  },
                ),
                SizedBox(width: 40),
                ButtonHomeWidget(assetPath: 'lib/assets/img/addcat_button.svg', labelButton: 'Tambah Kategori')
              ],
            ),
            Padding(
                padding: EdgeInsets.all(21),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF6AB70).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      offset: Offset(0,4)
                                  )
                                ]
                            ),
                            width: double.infinity,
                            height: 53,
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                SvgPicture.asset(
                                    'lib/assets/icon/history_icon.svg'
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'Riwayat',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFEA8D45)
                                  ),
                                )
                              ],
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.all(14),
                          child: Container(
                            padding: EdgeInsets.only(left: 12, right: 12, top: 6),
                            width: double.infinity,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF6AB70),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              'Kucing',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    )

                )
            ),
            Padding(
                padding: EdgeInsets.all(21),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF6AB70).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      offset: Offset(0,4)
                                  )
                                ]
                            ),
                            width: double.infinity,
                            height: 53,
                            child: Row(
                              children: [
                                SizedBox(width: 20),
                                SvgPicture.asset(
                                  'lib/assets/icon/catatan_icon.svg',
                                  width: 16,
                                  height: 16,
                                ),
                                SizedBox(width: 7),
                                Text(
                                  'Catatan',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFEA8D45)
                                  ),
                                )
                              ],
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.all(14),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 10, top: 4),
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEA8D45),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Kucing',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'Lucu, minus banyak',
                                            style: TextStyle(
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
                            )
                        )
                      ],
                    )

                )
            )
          ],
        ),
      ),
    );
  }
}
