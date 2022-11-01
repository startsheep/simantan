import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/theme/colors.dart';

class ButtonPrimary extends StatelessWidget {
  final dynamic onPressed;
  final String? label;
  const ButtonPrimary({
    Key? key,
    this.onPressed,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SchemaColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
