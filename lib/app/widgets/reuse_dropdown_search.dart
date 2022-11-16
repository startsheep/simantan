import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simantan/app/controllers/post_controller.dart';
import 'package:simantan/app/theme/colors.dart';
import 'package:simantan/app/widgets/reuse_textfield.dart';

class ReuseDropDownSearch extends StatelessWidget {
  final dynamic asyncItems;
  final dynamic onChange;
  final dynamic filterFn;
  final dynamic itemAsString;
  final String? title;
  final ValueChanged<String>? onSearch;
  final List<dynamic>? items;

  ReuseDropDownSearch({
    Key? key,
    this.asyncItems,
    this.onChange,
    this.filterFn,
    this.itemAsString,
    this.title,
    this.items,
    this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      itemAsString: itemAsString,
      items: items!,
      popupProps: PopupProps.modalBottomSheet(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // make tagar oor hastag
                  const Icon(
                    Icons.tag,
                    color: SchemaColor.primary,
                    size: 50,
                  ),

                  Text(
                    title!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ReuseTextField(
                          hintText: "Cari Tagar", onChanged: onSearch)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ),
      // asyncItems: (text) {
      //   return asyncItems;
      // },
      filterFn: filterFn,
      onChanged: onChange,
      validator: (value) {
        if (value == null) {
          return "tidak boleh kosong";
        }
        return null;
      },
    );
  }
}
