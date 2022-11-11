import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  SearchView({Key? key}) : super(key: key);
  // int tag = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReuseTextField(
                  suffixIcon: Icons.search,
                  hintText: "Cari",
                ),
                Divider(),
                controller.flags.length > 0
                    ? ChipsChoice<int>.single(
                        // spinnerColor: SchemaColor.primary,
                        leading: Text("Tagar",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        value: controller.selectedChip.value,
                        onChanged: (val) => {
                          controller.selectedChip.value = val,
                        },
                        choiceItems: C2Choice.listFrom<int, dynamic>(
                          source: controller.flags,
                          value: (i, v) => i,
                          label: (i, v) => '#' + v['name'],
                        ),
                        choiceBuilder: (item, i) {
                          return Container(
                            margin: EdgeInsets.only(right: 5, left: 2),
                            child: ChoiceChip(
                              label: Text(item.label,
                                  style: TextStyle(color: Colors.white)),
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
                    : Container(),
                // Expanded(child: ListView()),
                _buildUser()
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1616166330073-8b8b5b2b5b1a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rizky",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                " 1 jam yang lalu",
              )
            ],
          ),
        ],
      ),
    );
  }
}
