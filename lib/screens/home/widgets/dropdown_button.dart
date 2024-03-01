import 'package:flutter/material.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class DropdownButtonForm extends StatefulWidget {
  const DropdownButtonForm({super.key});

  @override
  State<DropdownButtonForm> createState() => _DropdownButtonFormState();
}

class _DropdownButtonFormState extends State<DropdownButtonForm> {
  String dropdownValue = 'Today';
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
          width: width / 5,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 8.w, right: 5.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide:
                const BorderSide(color: AppColors.c646FD4),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide:
                const BorderSide(color: AppColors.c646FD4),
              ),
            ),
            borderRadius: BorderRadius.circular(12),
            value: dropdownValue,
            items: <String>['Today', 'Week', 'Month', 'Year']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTextStyles.jostRegular
                      .copyWith(color: AppColors.c7D7D7D, fontSize: 12),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
      ],
    );
  }
}
