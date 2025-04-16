import 'package:flutter/material.dart';
import 'package:stocku_app/app/modules/user/userPage.dart';
import 'package:stocku_app/app/widgets/headerApp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/user/homePage.dart';
import 'package:stocku_app/app/modules/product/katPage.dart';

import '../laporan/lapPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    KategoriPage(),
    LapPage(),
    UserPage(),
  ];

  void _onIconTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildNavItem({
    required String iconPath,
    required String filledIconPath,
    required String nama,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        _selectedIndex == index ? filledIconPath : iconPath,
        width: 30,
        height: 30,
      ),
      label: nama,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              if (_selectedIndex != 3 && _selectedIndex != 2)
                HeaderApp(),
              if (_selectedIndex != 3 && _selectedIndex != 2)
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 23),
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 82,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, -2),
              ),
            ],
        ),
        child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildNavItem(
              iconPath: 'lib/assets/icon/home_icon.svg',
              filledIconPath: 'lib/assets/icon/homefilled_icon.svg',
              nama: 'Home',
              index: 0
          ),
          _buildNavItem(
              iconPath: 'lib/assets/icon/kat_icon.svg',
              filledIconPath: 'lib/assets/icon/katfilled_icon.svg',
              nama: 'Kategori',
              index: 1
          ),
          _buildNavItem(
              iconPath: 'lib/assets/icon/lap_icon.svg',
              filledIconPath: 'lib/assets/icon/lap_icon.svg',
              nama: 'Laporan',
              index: 2
          ),
          _buildNavItem(
              iconPath: 'lib/assets/icon/userbar_icon.svg',
              filledIconPath: 'lib/assets/icon/userfilled_icon.svg',
              nama: 'Akun',
              index: 3
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFFBF69),
        unselectedItemColor: Color(0xFFFFBF69),
        selectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
        onTap: _onIconTapped,
      ),
      )
    );
  }
}
