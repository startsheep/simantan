import 'package:flutter/material.dart';

class ReuseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final int? minLines;
  final bool? obscureText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final Function? onChanged;
  final Function? onTap;
  final Function? onSubmitted;

  const ReuseTextField({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText,
    this.icon,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.labelText,
    this.maxLines,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        // labelText: "Deskripsi Di Sini Yaa",
        hintText: hintText,
        labelStyle: TextStyle(
            // color: Color.fromARGB(255, 137, 126, 255),
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              // color: Color.fromARGB(255, 137, 126, 255),
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              // color: Color.fromARGB(255, 137, 126, 255),
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              // color: Color.fromARGB(255, 137, 126, 255),
              ),
        ),
      ),
    );
  }
}
