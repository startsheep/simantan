import 'package:flutter/material.dart';
import 'package:simantan/app/theme/colors.dart';

class CountWidget extends StatelessWidget {
  String? title;
  int? count;
  CountWidget({Key? key, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: SchemaColor.dFontColor),
        ),
        Text(
          title ?? 'title',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 114, 114, 114),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
