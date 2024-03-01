import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/images/app_images.dart';

import '../../../data/local/local_database.dart';
import '../../../data/models/category/category_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';
import '../../routes.dart';

showCategorySelectDialog({
  required BuildContext context,
  required ValueChanged<int> categorySelection,
  required int categoryId,
}) async {
  int selectedCategoryId = categoryId;

  // List<CategoryModel> categories = await LocalDatabase.getAllCategories();
  List<CategoryModel> categories = [
    CategoryModel(
        iconPath: AppImages.school, name: 'School', color: AppColors.c2A8899),
    CategoryModel(
        iconPath: AppImages.work, name: 'Work', color: AppColors.c5EB0D2),
    CategoryModel(
        iconPath: AppImages.book, name: 'Read', color: AppColors.c646FD4),
    CategoryModel(
        iconPath: AppImages.shopping, name: 'Shop', color: AppColors.cBE8972),
    CategoryModel(
        iconPath: AppImages.workout, name: 'Work Out', color: AppColors.c83BC74)
  ];
  // categories += await LocalDatabase.getAllCategories();
  if (!context.mounted) return;
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
                      children: List.generate(categories.length + 1, (index) {
                        if (index == categories.length) {
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: AppColors.cD25EB0,
                                  width: 2.w,
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteNames.addCategory,
                                  arguments: () async {
                                categories =
                                    await LocalDatabase.getAllCategories();
                                setState(() {});
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 50,
                              color: AppColors.cD25EB0,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryId = categories[index].id!;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: selectedCategoryId == categories[index].id
                                  ? categories[index].color
                                  : categories[index].color.withOpacity(0.5),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 4.w),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  categories[index].iconPath,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.white, BlendMode.srcIn),
                                ),
                                5.getH(),
                                Text(
                                  categories[index].name,
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
                            categorySelection.call(selectedCategoryId);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Save",
                            style: AppTextStyles.robotoRegular.copyWith(
                              color: AppColors.c242F9B,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
