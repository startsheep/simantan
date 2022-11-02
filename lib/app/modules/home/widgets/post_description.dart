import 'package:flutter/material.dart';

class PostDescription extends StatelessWidget {
  String? username;
  String? description;
  String? hastag;
  String? time;
  PostDescription({
    Key? key,
    this.username,
    this.description,
    this.hastag,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username!,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(
            description!,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            '#' + hastag!,
            style: const TextStyle(
                color: Color.fromARGB(255, 80, 94, 248), fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            time!,
            style: const TextStyle(
                color: Color.fromARGB(255, 193, 193, 193), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
