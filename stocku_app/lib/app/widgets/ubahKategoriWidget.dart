import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/productController.dart';
import 'notifikasiWidget.dart' show NotifikasiWidget;

final productController = Get.put(ProductController());
void showUbahKategoriDialog(BuildContext context, TextEditingController controller, String namaLamaKategori, VoidCallback onSuccess)
{
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 14,bottom: 14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 19, left: 19),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icon/add2_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Ubah Nama Kategori',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 17),
              Padding(
                  padding: EdgeInsets.only(right: 29, left: 29),
                  child: Text(
                    'Nama Kategori',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),
              SizedBox(height: 8),
              Padding(
                  padding: EdgeInsets.only(right: 29, left: 29),
                  child: Container(
                    width: 260,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.33),
                          offset: Offset(0, 0),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEBEBEB),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  )
              ),
              SizedBox(height: 23),
              GestureDetector(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return NotifikasiWidget(
                          onYes: () {
                            productController.ubahKategori(namaLamaKategori, controller.text);
                          },
                          message: 'Apakah anda yakin mengubah kategori?',
                        );
                      });
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFE0904B),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      'Ubah',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
