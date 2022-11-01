import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:simantan/app/theme/colors.dart';

class ReuseDropDownSearch extends StatelessWidget {
  final dynamic asyncItems;
  final dynamic onChange;
  final dynamic filterFn;
  final dynamic itemAsString;
  final String? title;

  ReuseDropDownSearch({
    Key? key,
    this.asyncItems,
    this.onChange,
    this.filterFn,
    this.itemAsString,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch(
      itemAsString: itemAsString,
      popupProps: PopupProps.modalBottomSheet(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
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
        ),
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: "Cari "),
        ),
      ),
      asyncItems: (text) {
        return asyncItems;
      },
      filterFn: filterFn,
      onChanged: onChange,
      validator: (value) {
        if (value == null) {
          return "tidak boleh kosong";
        }
        return null;
      },
      clearButtonProps: ClearButtonProps(alignment: Alignment.centerRight),
    );
  }
}
