// import 'package:flutter/material.dart';

// class PostCard extends StatelessWidget {
//   const PostCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // boundary needed for web
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black12,
//         ),
//         color: Colors.black38,
//       ),
//       padding: const EdgeInsets.symmetric(
//         vertical: 10,
//       ),
//       child: Column(
//         children: [
//           // HEADER SECTION OF THE POST
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 4,
//               horizontal: 16,
//             ).copyWith(right: 0),
//             child: Row(
//               children: <Widget>[
//                 CircleAvatar(
//                   radius: 16,
//                   backgroundImage: NetworkImage(
//                     'http://placeimg.com/640/480/people',
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8,
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'ahmad',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 1 == 1
//                     ? IconButton(
//                         onPressed: () {
//                           showDialog(
//                             useRootNavigator: false,
//                             context: context,
//                             builder: (context) {
//                               return Dialog(
//                                 child: ListView(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 16),
//                                     shrinkWrap: true,
//                                     children: [
//                                       'Delete',
//                                     ]
//                                         .map(
//                                           (e) => InkWell(
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 12,
//                                                         horizontal: 16),
//                                                 child: Text(e),
//                                               ),
//                                               onTap: () {
//                                                 deletePost(
//                                                   widget.snap['postId']
//                                                       .toString(),
//                                                 );
//                                                 // remove the dialog box
//                                                 Navigator.of(context).pop();
//                                               }),
//                                         )
//                                         .toList()),
//                               );
//                             },
//                           );
//                         },
//                         icon: const Icon(Icons.more_vert),
//                       )
//                     : Container(),
//               ],
//             ),
//           ),
//           // IMAGE SECTION OF THE POST
//           GestureDetector(
//             onDoubleTap: () {},
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   width: double.infinity,
//                   child: Image.network(
//                     widget.snap['postUrl'].toString(),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 AnimatedOpacity(
//                   duration: const Duration(milliseconds: 200),
//                   opacity: isLikeAnimating ? 1 : 0,
//                   child: LikeAnimation(
//                     isAnimating: isLikeAnimating,
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                     duration: const Duration(
//                       milliseconds: 400,
//                     ),
//                     onEnd: () {
//                       setState(() {
//                         isLikeAnimating = false;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // LIKE, COMMENT SECTION OF THE POST
//           Row(
//             children: <Widget>[
//               LikeAnimation(
//                 isAnimating: widget.snap['likes'].contains(user.uid),
//                 smallLike: true,
//                 child: IconButton(
//                   icon: widget.snap['likes'].contains(user.uid)
//                       ? const Icon(
//                           Icons.favorite,
//                           color: Colors.red,
//                         )
//                       : const Icon(
//                           Icons.favorite_border,
//                         ),
//                   onPressed: () => FireStoreMethods().likePost(
//                     widget.snap['postId'].toString(),
//                     user.uid,
//                     widget.snap['likes'],
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.comment_outlined,
//                 ),
//                 onPressed: () => Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => CommentsScreen(
//                       postId: widget.snap['postId'].toString(),
//                     ),
//                   ),
//                 ),
//               ),
//               IconButton(
//                   icon: const Icon(
//                     Icons.send,
//                   ),
//                   onPressed: () {}),
//               Expanded(
//                   child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: IconButton(
//                     icon: const Icon(Icons.bookmark_border), onPressed: () {}),
//               ))
//             ],
//           ),
//           //DESCRIPTION AND NUMBER OF COMMENTS
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 DefaultTextStyle(
//                     style: Theme.of(context)
//                         .textTheme
//                         .subtitle2!
//                         .copyWith(fontWeight: FontWeight.w800),
//                     child: Text(
//                       '${widget.snap['likes'].length} likes',
//                       style: Theme.of(context).textTheme.bodyText2,
//                     )),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.only(
//                     top: 8,
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       style: const TextStyle(color: primaryColor),
//                       children: [
//                         TextSpan(
//                           text: widget.snap['username'].toString(),
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         TextSpan(
//                           text: ' ${widget.snap['description']}',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   child: Container(
//                     child: Text(
//                       'View all $commentLen comments',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         color: secondaryColor,
//                       ),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                   ),
//                   onTap: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => CommentsScreen(
//                         postId: widget.snap['postId'].toString(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Text(
//                     DateFormat.yMMMd()
//                         .format(widget.snap['datePublished'].toDate()),
//                     style: const TextStyle(
//                       color: secondaryColor,
//                     ),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
