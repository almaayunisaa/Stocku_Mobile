import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String iconPath;
  final TextEditingController? controller;

  const CustomTextField({super.key, required this.hintText, required this.iconPath, this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Color(0xFFEA8D45),
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w300
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Color(0xFFEA8D45),
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(
              color: Color(0xFFEA8D45),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Color(0xFFFFE7C6),
        ),
      ),
    );
  }
}