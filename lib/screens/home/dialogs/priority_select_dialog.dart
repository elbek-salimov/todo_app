import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';

import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

showPrioritySelectDialog({
  required BuildContext context,
  required ValueChanged<int> priority,
  required int selectedPriority,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          width = MediaQuery.of(context).size.width;
          height = MediaQuery.of(context).size.height;
          return AlertDialog(
            scrollable: false,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Center(
              child: Text(
                "Task Priority",
                style: AppTextStyles.jostSemiBold,
              ),
            ),
            content: SizedBox(
              width: width,
              height: height / 3,
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 5,
                      childAspectRatio: 0.5,
                      crossAxisSpacing: 10.w,
                      children: List.generate(10, (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPriority = index + 1;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                    color: (index + 1) == selectedPriority
                                        ? Colors.green
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.asset(AppImages.flag),
                              ),
                            ),
                            10.getH(),
                            Text(
                              (index + 1).toString(),
                              style: AppTextStyles.robotoMedium
                                  .copyWith(color: Colors.black),
                            ),
                          ],
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
                          child: const Text("Cancel", style: AppTextStyles.robotoRegular),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            priority.call(selectedPriority);
                            Navigator.pop(context);
                          },
                          child: Text("Save", style: AppTextStyles.robotoRegular.copyWith(
                            color: AppColors.c242F9B
                          )),
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
