import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stocku_app/app/controllers/productController.dart';
import 'package:get/get.dart';

class NotifikasiWidget extends StatelessWidget {
  final productController = Get.put(ProductController());
  final VoidCallback onYes;
  final String message;

  NotifikasiWidget({
    Key? key,
    required this.onYes, required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 19),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'lib/assets/icon/warn_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pesan Konfirmasi',
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

            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.only(right: 39, left: 39),
              child: Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE0904B),
                    ),
                  ),
              )
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(0xFFEBEBEB),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Tidak',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onYes();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFE0904B),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Ya',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

