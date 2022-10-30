import 'package:flutter/material.dart';
import 'package:simantan/app/theme/colors.dart';

class OutlineButton extends StatelessWidget {
  String? label;
  Function()? onPressed;
  OutlineButton({
    Key? key,
    this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: SchemaColor.primary),
        ),
      ),
      onPressed: onPressed ?? () {},
      child: Text(
        label ?? "Label",
        style: const TextStyle(
          color: SchemaColor.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
