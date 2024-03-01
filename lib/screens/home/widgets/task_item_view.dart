import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/extension/app_extensions.dart';
import 'package:todo_app/utils/images/app_images.dart';

import '../../../data/models/task/task_model.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class TaskItemView extends StatelessWidget {
  const TaskItemView({
    super.key,
    required this.taskModel,
    required this.onDelete,
    required this.onUpdate,
    required this.onStatusUpdate,
  });

  final TaskModel taskModel;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onStatusUpdate;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 4.h, left: 15.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.3),
              blurRadius: 2,
            )
          ]),
      child: Material(
        color: AppColors.transparent,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width / 1.5,
                  child: Text(
                    taskModel.title,
                    style: AppTextStyles.jostRegular
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Text(
                  (taskModel.deadline.millisecondsSinceEpoch.getParsedHour())
                      .toString(),
                  style: AppTextStyles.jostRegular.copyWith(fontSize: 14),
                ),
                Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: taskModel.status.name == "completed"
                              ? AppColors.c646FD4
                              : AppColors.c2A8899,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(left: 4.w, right: 4.w),
                          minimumSize: Size(0, 10.h)),
                      onPressed: onStatusUpdate,
                      child: Text(
                        taskModel.status.name,
                        style: AppTextStyles.jostMedium.copyWith(
                          fontSize: 18,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    20.getW(),
                    Container(
                      height: 22.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.c646FD4)),
                      child: Row(
                        children: [
                          Image.asset(AppImages.priority),
                          2.getW(),
                          Text(taskModel.priority.toString())
                        ],
                      ),
                    ),
                    10.getW(),
                    Container(
                      height: 22.h,
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.c646FD4)),
                      child: Row(
                        children: [
                          Image.asset(AppImages.priority),
                          2.getW(),
                          Text(taskModel.category.toString())
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: onUpdate,
                  child: Text('edit task',
                      style: AppTextStyles.jostRegular.copyWith(fontSize: 18)),
                ),
                PopupMenuItem<String>(
                  onTap: onDelete,
                  child: Text('delete task',
                      style: AppTextStyles.jostRegular
                          .copyWith(fontSize: 18, color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
