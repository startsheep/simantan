import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostContent extends StatelessWidget {
  String? contentUrl;
  PostContent({
    Key? key,
    this.contentUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 215, 215, 215).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 2,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InteractiveViewer(
        onInteractionEnd: (details) {
          //set the scale to 1.0
        },
        // boundaryMargin: EdgeInsets.all(20.0),
        alignPanAxis: true,
        child: Image.network(
          contentUrl!,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              // place holder image from assets
              width: Get.width,
              height: Get.width,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/placeholder_image.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
