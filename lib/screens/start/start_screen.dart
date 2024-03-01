import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/constants/storage_keys.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/styles/app_text_styles.dart';

import '../../utils/size/app_size.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.c646FD4,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60.h, bottom: 32.h),
          child: Column(
            children: [
              SizedBox(
                height: height / 2,
                child: Image.asset(AppImages.welcome),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 24.h),
                child: Column(
                  children: [
                    const Text('Manage your tasks',
                        style: AppTextStyles.jostMedium),
                    8.getH(),
                    const Text(
                      'organize, plan, and collaborate on tasks with Mtodo.'
                      'Your busy life deserves this.you can manage '
                      'checklist and your goal. ',
                      style: AppTextStyles.robotoRegular,
                      textAlign: TextAlign.center,
                    ),
                    32.getH(),
                    InkWell(
                      onTap: () {
                        if (StorageRepository.getString(
                                key: StorageKeys.nameKey)
                            .isNotEmpty) {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.home);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.register);
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColors.c9BA3EB,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text('Get Started',
                                style: AppTextStyles.robotoMedium)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
