import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostUser extends StatelessWidget {
  String? username;
  String? avatarUrl;
  bool? isActive;
  PostUser({
    Key? key,
    this.username,
    this.avatarUrl,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 224, 224, 224).withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              blurStyle: BlurStyle.inner,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: isActive! ? Colors.green : Colors.grey,
          child: CircleAvatar(
            radius: 24,
            backgroundImage: avatarUrl == null
                ? const AssetImage('assets/avatar.png')
                : Image.network(avatarUrl!).image,
          ),
        ),
      ),
      title: InkWell(
        onTap: () {},
        child: Text(
          username!,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      // subtitle: Text(
      //   '#' +
      //       controller.postController.posts[index]
      //           ['hastag'],
      //   style: const TextStyle(
      //       color: Colors.black, fontSize: 16),
      // ),
    );
  }
}
