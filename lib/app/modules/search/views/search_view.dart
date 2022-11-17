import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/modules/home/widgets/post_actions.dart';
import 'package:simantan/app/modules/home/widgets/post_content.dart';
import 'package:simantan/app/modules/home/widgets/post_description.dart';
import 'package:simantan/app/modules/home/widgets/post_user.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  SearchView({Key? key}) : super(key: key);
  // int tag = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // like instagram
          elevation: 0,
          centerTitle: true,
          backgroundColor: SchemaColor.primary,
          title: Text(
            'Pencarian',
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ReuseTextField(
                    controller: controller.searchController.value,
                    suffixIcon: Icons.search,
                    hintText: "Cari",
                    onChanged: (value) => controller.searchText.value = value,
                  ),
                  Divider(),
                  // Tabs Tagar or Post
                  // Row from Tabs Tagar or Post and make it e
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.tabs
                        .map((e) => Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.selectedTab.value = e['value'];
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: controller.selectedTab.value ==
                                            e['value']
                                        ? SchemaColor.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: controller.selectedTab.value ==
                                            e['value']
                                        ? Border.all(color: Colors.transparent)
                                        : Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: Text(
                                      e['name'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: controller.selectedTab.value ==
                                                  e['value']
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Divider(),
                  _tabView(controller.selectedTab.value),
                  // Expanded(child: ListView()),
                ],
              );
            }),
          ),
        ));
  }

  Widget _tabView(int value) {
    switch (value) {
      case 0:
        return _buildHashtag();
      case 1:
        return _buildPosts();
      default:
        return _buildUsers();
    }
  }

  Widget _buildUsers() {
    return Expanded(child: ListView());
  }

  Widget _buildPosts() {
    // like home
    return Expanded(
      child: ListView.builder(
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final post = controller.posts[index];
          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostUser(
                  username: post['user']['name'],
                  avatarUrl: post['user']['image'],
                  isActive: post['user']['is_active'] ?? false,
                ),
                PostContent(
                  contentUrl: post['image'],
                ),
                Divider(),
                // PostActions(
                //   postId: controller.posts[index]['id'],
                // ),
                PostDescription(
                  username: post['user']['name'],
                  description: post['description'],
                  hastag: post['flag']['name'],
                  time: post['created_at'],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHashtag() {
    return controller.flags.length > 0
        ? ChipsChoice<int>.single(
            // spinnerColor: SchemaColor.primary,

            leading: Text("Tagar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            value: controller.selectedChip.value,
            onChanged: (val) => {
              controller.selectedChip.value = val,
            },
            choiceItems: C2Choice.listFrom<int, dynamic>(
              source: controller.flags,
              value: (i, v) => i,
              label: (i, v) => parseToHashTag(v['name']),
            ),
            choiceBuilder: (item, i) {
              return Container(
                margin: EdgeInsets.only(right: 5, left: 2),
                child: ChoiceChip(
                  label:
                      Text(item.label, style: TextStyle(color: Colors.white)),
                  selected: item.selected,
                  onSelected: (selected) {
                    controller.selectedChip.value = item.value;
                  },
                  backgroundColor: Colors.black38,
                  selectedColor: SchemaColor.primary,
                ),
              );
            },
          )
        : Container();
  }

  String parseToHashTag(String text) {
    // concatenate text with spaces and add hashtags make camel case
    return '#' + text.replaceAll(RegExp(r'(\s)+'), '');
    // return "#" + text.split(" ").join("");
  }
}
