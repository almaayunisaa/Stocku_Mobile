import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/product/produkPage.dart';

class KategoriPage extends StatelessWidget {
  const KategoriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'DAFTAR KATEGORI',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEA8D45)
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'lib/assets/icon/addcatshad_icon.svg',
                    width: 25,
                    height: 25,
                  )
                ],
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: double.infinity,
                  height: 42,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Rumah Tangga',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'lib/assets/icon/edit_icon.svg',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 6),
                      SvgPicture.asset(
                        'lib/assets/icon/del_icon.svg',
                        width: 20,
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    )
    );
  }
}
