import 'package:flutter/material.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/screens/routes.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/constants/storage_keys.dart';
import 'package:todo_app/utils/extension/app_extensions.dart';
import 'package:todo_app/utils/styles/app_text_styles.dart';

import '../../utils/size/app_size.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool checkedValue = false;
  bool checkboxIsError = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 56.h, left: 16.w, right: 16.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Task Master', style: AppTextStyles.jostSemiBold),
              60.getH(),
              Center(
                child: Column(
                  children: [
                    const Text('Hello!', style: AppTextStyles.jostMedium),
                    Text('welcome to Task Master app\nsign up to get started.',
                        style: AppTextStyles.jostMedium.copyWith(fontSize: 16),
                        maxLines: 2,
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              30.getH(),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'your name',
                        hintStyle: AppTextStyles.robotoRegular,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.cD9D9D9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    16.getH(),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.isValidEmail()) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'enter email',
                        hintStyle: AppTextStyles.robotoRegular,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.cD9D9D9),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.blueAccent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    side: BorderSide(
                        color: checkboxIsError == true
                            ? Colors.red
                            : AppColors.c888888),
                    focusColor: Colors.red,
                    activeColor: AppColors.c646FD4,
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                        text: 'Agree to ',
                        style: AppTextStyles.jostMedium
                            .copyWith(fontSize: 12, color: AppColors.c888888),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            style:
                                AppTextStyles.jostMedium.copyWith(fontSize: 12),
                          )
                        ]),
                  ),
                ],
              ),
              10.getH(),
              InkWell(
                onTap: () async {
                  final isValidate = formKey.currentState!.validate();
                  if (isValidate && checkedValue) {
                    StorageRepository.setString(
                      key: StorageKeys.nameKey,
                      value: nameController.text,
                    );
                    StorageRepository.setString(
                      key: StorageKeys.emailKey,
                      value: emailController.text,
                    );
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, RouteNames.home);
                    }
                  }
                  if (checkedValue == false) {
                    setState(() {
                      checkboxIsError = true;
                    });
                    return;
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.c646FD4,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text('SIGN UP', style: AppTextStyles.robotoMedium)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
