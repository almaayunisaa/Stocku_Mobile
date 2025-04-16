import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderApp extends StatelessWidget {

  const HeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.all(19),
            child: SvgPicture.asset(
              'lib/assets/img/stocku_logo.svg',
            ),
          )
        ],
      ),
    );
  }
}