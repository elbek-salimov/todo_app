import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/home/widgets/profile_photo_view.dart';
import 'package:todo_app/utils/images/app_images.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/size/app_size.dart';
import '../../../utils/styles/app_text_styles.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key, required this.userName, required this.email});

  final String userName;
  final String email;

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Drawer(
      width: width / 1.5,
      backgroundColor: AppColors.cF6F6F6,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.c646FD4,
                  ),
                ),
                Row(
                  children: [
                    const ProfilePhoto(),
                    8.getW(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userName,
                            style: AppTextStyles.jostRegular.copyWith(
                              fontSize: 16,
                              color: AppColors.c242F9B,
                            ),
                          ),
                          Text(
                            widget.email,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyles.jostRegular.copyWith(
                              fontSize: 12,
                              color: AppColors.c888888,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(AppImages.edit,
                colorFilter:
                    const ColorFilter.mode(AppColors.c888888, BlendMode.srcIn)),
            title: Text('Edit profile',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: SvgPicture.asset(
              AppImages.dailyPic,
              colorFilter:
                  const ColorFilter.mode(AppColors.c888888, BlendMode.srcIn),
            ),
            title: Text('Daily tasks',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: SvgPicture.asset(AppImages.star,
                colorFilter:
                    const ColorFilter.mode(AppColors.c888888, BlendMode.srcIn)),
            title: Text('Important tasks',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: SvgPicture.asset(AppImages.doneAll,
                colorFilter:
                    const ColorFilter.mode(AppColors.c888888, BlendMode.srcIn)),
            title: Text('Done tasks',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text('Calendar',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text('Focus',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text('About',
                style: AppTextStyles.jostRegular
                    .copyWith(fontSize: 12, color: AppColors.c888888)),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
