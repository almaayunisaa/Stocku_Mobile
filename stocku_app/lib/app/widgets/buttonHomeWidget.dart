import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonHomeWidget extends StatelessWidget {
  final String assetPath;
  final String labelButton;

  const ButtonHomeWidget({super.key, required this.assetPath, required this.labelButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (labelButton == "Tambah Produk")
            SizedBox(height: 14),
          SvgPicture.asset(
              assetPath,
          ),
          if (labelButton == "Tambah Produk")
            SizedBox(height: 11),
          Text(
              labelButton,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF696969)
              ),
          )
        ],
      ),
    );
  }
}
