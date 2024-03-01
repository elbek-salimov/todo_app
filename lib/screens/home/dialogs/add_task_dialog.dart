import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/home/dialogs/category_select_dialog.dart';
import 'package:todo_app/screens/home/dialogs/priority_select_dialog.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/styles/app_text_styles.dart';

import '../../../data/models/task/task_model.dart';
import '../../../utils/size/app_size.dart';

addTaskDialog({
  required BuildContext context,
  required ValueChanged<TaskModel> taskModelChanged,
}) async {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TaskModel taskModel = TaskModel.initialValue;

  bool favorite = false;

  DateTime? dateTime;
  TimeOfDay? timeOfDay;

  int categoryId = 0;
  int priority = 1;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 10.w, right: 10.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              const Text(
                "Add Task",
                style: AppTextStyles.jostSemiBold,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    favorite = !favorite;
                  });
                },
                icon: SvgPicture.asset(
                  AppImages.star,
                  colorFilter: ColorFilter.mode(
                      favorite == true ? AppColors.cFFD952 : AppColors.c7D7D7D,
                      BlendMode.srcIn),
                ),
              )
            ],
          ),
          content: SizedBox(
            width: width,
            height: height / 3,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: AppColors.c888888, blurRadius: 5),
                    ],
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    focusNode: focusNode1,
                    controller: titleController,
                    onChanged: (v) {
                      taskModel = taskModel.copyWith(title: v);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10.w),
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: 'task here',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.transparent),
                      ),
                    ),
                  ),
                ),
                TextField(
                  maxLines: 4,
                  textInputAction: TextInputAction.done,
                  focusNode: focusNode2,
                  onChanged: (v) {
                    taskModel = taskModel.copyWith(description: v);
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    contentPadding: EdgeInsets.only(top: 30.h),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.transparent),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.transparent),
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        dateTime = await showDatePicker(
                            cancelText: "Cancel",
                            confirmText: "Ok",
                            barrierDismissible: false,
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                            currentDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      onPrimary: Colors.black,
                                      // selected text color
                                      onSurface: Colors.amberAccent,
                                      // default text color
                                      primary:
                                          Colors.amberAccent // circle color
                                      ),
                                  dialogBackgroundColor: Colors.black54,
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.amber,
                                      textStyle: const TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          fontFamily: 'Quicksand'),
                                      // color of button's letters
                                      backgroundColor: Colors.black54,
                                      // Background color
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            });

                        if (dateTime != null) {
                          setState(() {
                            taskModel = taskModel.copyWith(deadline: dateTime);
                          });
                        }
                      },
                      icon: SizedBox(
                        height: 25.h,
                        child: Image.asset(AppImages.calendar),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        timeOfDay = await showTimePicker(
                            context: context,
                            initialEntryMode: TimePickerEntryMode.input,
                            initialTime: const TimeOfDay(hour: 8, minute: 0),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: const ColorScheme.dark(
                                      onPrimary: Colors.black,
                                      // selected text color
                                      onSurface: Colors.amberAccent,
                                      // default text color
                                      primary:
                                          Colors.amberAccent // circle color
                                      ),
                                  dialogBackgroundColor: Colors.black54,
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.amber,
                                      textStyle: const TextStyle(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          fontFamily: 'Quicksand'),
                                      // color of button's letters
                                      backgroundColor: Colors.black54,
                                      // Background color
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            });

                        if (timeOfDay != null) {
                          DateTime d = taskModel.deadline;
                          d.copyWith(
                            hour: timeOfDay!.hour,
                            minute: timeOfDay!.minute,
                          );
                          setState(() {
                            taskModel = taskModel.copyWith(deadline: d);
                          });
                        }
                      },
                      icon: SizedBox(
                        height: 25.h,
                        child: Image.asset(AppImages.clock),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showCategorySelectDialog(
                          context: context,
                          categorySelection: (selectedCategoryName) {
                            setState(() {
                              categoryId = categoryId;
                            });
                            taskModel =
                                taskModel.copyWith(categoryId: categoryId);
                          },
                          categoryId: categoryId,
                        );
                      },
                      icon: SizedBox(
                        height: 25.h,
                        child: Image.asset(AppImages.category),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        showPrioritySelectDialog(
                          selectedPriority: taskModel.priority,
                          context: context,
                          priority: (p) {
                            setState(() {
                              priority = p;
                            });
                            taskModel = taskModel.copyWith(priority: p);
                          },
                        );
                      },
                      icon: SizedBox(
                        height: 25.h,
                        child: Image.asset(AppImages.priority),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        if (taskModel.canAddTaskToDatabase()) {
                          taskModelChanged.call(taskModel);
                          Navigator.pop(context);
                        } else {}
                      },
                      icon: SizedBox(
                        height: 25.h,
                        child: SvgPicture.asset(AppImages.next),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
