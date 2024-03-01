import 'package:todo_app/data/models/category/category_model.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';

class CategoryItem{
  static List<CategoryModel> categories = [
    CategoryModel(iconPath: AppImages.school, name: 'School', color: AppColors.c2A8899),
    CategoryModel(iconPath: AppImages.work, name: 'Work', color: AppColors.c5EB0D2),
    CategoryModel(iconPath: AppImages.shopping, name: 'Shop', color: AppColors.cBE8972),
    CategoryModel(iconPath: AppImages.book, name: 'Read', color: AppColors.c646FD4),
    CategoryModel(iconPath: AppImages.health, name: 'Health', color: AppColors.c83BC74),
    CategoryModel(iconPath: AppImages.movie, name: 'Social', color: AppColors.c242F9B),
  ];
}