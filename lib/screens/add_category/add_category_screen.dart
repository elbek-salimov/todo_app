import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/styles/app_text_styles.dart';

import '../../data/local/local_database.dart';
import '../../data/models/category/category_model.dart';
import '../../utils/size/app_size.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key, this.onCategoryAdded});

  final VoidCallback? onCategoryAdded;

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String categoryName = '';
  int selectedIconIndex = -1;
  int selectedColorIndex = -1;

  List<Color> colors = [
    AppColors.c2A8899,
    AppColors.cBE8972,
    AppColors.c83BC74,
    AppColors.cD25EB0,
    AppColors.cFFD952,
    AppColors.c646FD4,
    AppColors.c242F9B,
    AppColors.cA31D00,
    AppColors.c21A300,
    AppColors.cFF9680,
  ];

  List<String> icons = [
    AppImages.design,
    AppImages.grocery,
    AppImages.health,
    AppImages.home,
    AppImages.music,
    AppImages.movie,
    AppImages.social,
  ];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(top: 30.h, left: 16.w, right: 16.w, bottom: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Category', style: AppTextStyles.jostMedium),
            20.getH(),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 8.h),
                height: 80.w,
                width: 80.w,
                decoration: BoxDecoration(
                  color: selectedColorIndex >= 0
                      ? colors[selectedColorIndex]
                      : AppColors.c888888,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    selectedIconIndex >= 0
                        ? SvgPicture.asset(
                            icons[selectedIconIndex],
                            colorFilter: const ColorFilter.mode(
                                AppColors.white, BlendMode.srcIn),
                          )
                        : const SizedBox(),
                    4.getH(),
                    Text(
                      categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.robotoRegular
                          .copyWith(color: AppColors.white, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            30.getH(),
            Text(
              'Category name',
              style: AppTextStyles.jostMedium.copyWith(fontSize: 16),
            ),
            5.getH(),
            TextField(
              onChanged: (v) {
                categoryName = v;
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'name here',
                filled: true,
                fillColor: AppColors.cD9D9D9,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: AppColors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: AppColors.transparent)),
              ),
            ),
            20.getH(),
            Text(
              'Category icon',
              style: AppTextStyles.jostMedium.copyWith(fontSize: 16),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    icons.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        onPressed: () {
                          selectedIconIndex = index;
                          setState(() {});
                        },
                        icon: SvgPicture.asset(
                          icons[index],
                          colorFilter: ColorFilter.mode(
                              selectedIconIndex == index
                                  ? Colors.green
                                  : Colors.black,
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.getH(),
            Text(
              'Category color',
              style: AppTextStyles.jostMedium.copyWith(fontSize: 16),
            ),
            5.getH(),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    colors.length,
                    (index) => IconButton(
                      onPressed: () {
                        selectedColorIndex = index;
                        setState(() {});
                      },
                      icon: Stack(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                color: colors[index], shape: BoxShape.circle),
                          ),
                          if (selectedColorIndex == index)
                            const Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: AppTextStyles.jostMedium
                        .copyWith(fontSize: 18, color: AppColors.c888888),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedColorIndex > -1 &&
                        selectedIconIndex > -1 &&
                        categoryName.isNotEmpty) {
                      await LocalDatabase.insertCategory(
                        CategoryModel(
                          iconPath: icons[selectedIconIndex],
                          name: categoryName,
                          color: colors[selectedColorIndex],
                        ),
                      );
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.only(
                              bottom: 5.h, top: 5.h, left: 10.w),
                          backgroundColor: Colors.blueAccent,
                          content: const Text("Category saved!!"),
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                        if (widget.onCategoryAdded != null) {
                          widget.onCategoryAdded!.call();
                        }
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: EdgeInsets.only(
                              bottom: 5.h, top: 5.h, left: 10.w),
                          backgroundColor: Colors.redAccent,
                          content: const Text("Form isn't completed!"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Save',
                    style: AppTextStyles.jostMedium.copyWith(fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
