import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data/models/category/category_item.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

showCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<String> categorySelection,
  required String category,
}) {
  String selectedCategory = category;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          width = MediaQuery.of(context).size.width;
          height = MediaQuery.of(context).size.height;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Center(
              child: Text(
                "Task Category",
                style: AppTextStyles.jostSemiBold,
              ),
            ),
            content: SizedBox(
              width: width,
              height: height / 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      childAspectRatio: 0.9,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      children: List.generate(CategoryItem.categories.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory =
                                  CategoryItem.categories[index].name;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: selectedCategory ==
                                      CategoryItem.categories[index].name
                                  ? CategoryItem.categories[index].color
                                  : CategoryItem.categories[index].color
                                      .withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 4.w),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  CategoryItem.categories[index].iconPath,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.white, BlendMode.srcIn),
                                ),
                                Text(
                                  CategoryItem.categories[index].name,
                                  style: AppTextStyles.jostRegular.copyWith(
                                      fontSize: 14, color: AppColors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel",
                              style: AppTextStyles.robotoRegular),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            categorySelection.call(selectedCategory);
                            Navigator.pop(context);
                          },
                          child: Text("Save",
                              style: AppTextStyles.robotoRegular
                                  .copyWith(color: AppColors.c242F9B)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
