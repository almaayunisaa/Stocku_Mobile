import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/product/infoProdukPage.dart';
import 'package:stocku_app/app/modules/product/addProdPage.dart';

class ProdukPage extends StatelessWidget {
  const ProdukPage({super.key});

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
                          'Rumah Tangga',
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
                Padding(
                  padding: EdgeInsets.only(right: 23, left: 23, top: 16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.01),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: SearchBar(
                          hintText: 'Cari produk',
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15,
                                color: Color(0xFFB9B9B9)
                            ),
                          ),
                          trailing: [
                            IconButton(
                              icon: SvgPicture.asset(
                                'lib/assets/icon/search_icon.svg',
                                width: 16,
                                height: 16,
                              ),
                              onPressed: () {
                                print('Button Clicked!');
                              },
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InfoProdukPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 17, bottom: 17),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
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
                                    'Kucing',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Rp5.000,-',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 24),
                                  Text(
                                    '#Kode',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '20 pcs',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProdPage()),
          );
        },
        child: SvgPicture.asset(
          'lib/assets/img/add_button.svg',
          width: 70,
          height: 70,
        )
      ),
    );
  }
}
