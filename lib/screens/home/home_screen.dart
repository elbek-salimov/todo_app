import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:todo_app/screens/home/widgets/dropdown_button.dart';
import 'package:todo_app/screens/home/widgets/menu_view.dart';
import 'package:todo_app/screens/home/widgets/task_item_view.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/constants/storage_keys.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/styles/app_text_styles.dart';
import 'package:todo_app/utils/extension/app_extensions.dart';

import '../../data/local/local_database.dart';
import '../../data/models/task/task_model.dart';
import '../../utils/size/app_size.dart';
import 'dialogs/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.stream});

  final Stream? stream;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime now = DateTime.now();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  TaskModel taskModel = TaskModel.initialValue;

  List<TaskModel> tasks = [];

  _init() async {
    tasks = await LocalDatabase.getAllTasks();
    setState(() {});
  }

  _searchQuery(String q) async {
    tasks = await LocalDatabase.searchTasks(q);
    setState(() {});
  }

  @override
  void initState() {
    _init();
    if (widget.stream != null) {
      widget.stream!.listen((event) {
        _init();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskDialog(
            context: context,
            taskModelChanged: (task) {
              LocalDatabase.insertTask(task);
              _init();
            },
          );
        },
        backgroundColor: AppColors.c646FD4,
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: NavDrawer(
        userName: StorageRepository.getString(key: StorageKeys.nameKey),
        email: StorageRepository.getString(key: StorageKeys.emailKey),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 235.w,
              width: 235.w,
              child: SvgPicture.asset(AppImages.roundTwo, fit: BoxFit.cover),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 279.w,
              height: 279.w,
              child: SvgPicture.asset(AppImages.roundOne, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 32.h, bottom: 30.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Material(
                      color: AppColors.transparent,
                      child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Task Manager',
                      style: AppTextStyles.jostSemiBold
                          .copyWith(fontSize: 20, color: AppColors.white),
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        height: 40.w,
                        width: 40.w,
                        child:
                            Image.asset(AppImages.profile, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
                31.getH(),
                RichText(
                  text: TextSpan(
                      text: 'you have ',
                      style: AppTextStyles.jostSemiBold
                          .copyWith(color: AppColors.black),
                      children: [
                        TextSpan(
                          text: '${tasks.length} tasks ',
                          style: AppTextStyles.jostSemiBold
                              .copyWith(color: AppColors.white, fontSize: 24),
                        ),
                        const TextSpan(text: 'today!')
                      ]),
                ),
                Text(
                  now.toFormattedString(),
                  style: AppTextStyles.jostMedium
                      .copyWith(fontSize: 12, color: AppColors.black),
                ),
                17.getH(),
                Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 24.w),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 5))
                    ]),
                    child: TextField(
                      onChanged: (v) {
                        _searchQuery(v);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: const Icon(Icons.search_outlined),
                        hintText: 'Search tasks',
                        hintStyle: AppTextStyles.jostRegular
                            .copyWith(fontSize: 16, color: AppColors.c888888),
                        filled: true,
                        fillColor: AppColors.white,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: AppColors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                20.getH(),
                const DropdownButtonForm(),
                tasks.isEmpty ? 40.getH() : 10.getH(),
                tasks.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 150.h,
                            child: Image.asset(AppImages.banner),
                          ),
                          Text(
                            'What do you want to do today?',
                            style: AppTextStyles.robotoRegular
                                .copyWith(fontSize: 20),
                          ),
                          10.getH(),
                          Text(
                            'Tap + to add your tasks',
                            style: AppTextStyles.robotoRegular
                                .copyWith(fontSize: 16),
                          ),
                          // const Spacer()
                        ],
                      )
                    : Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(
                            tasks.length,
                            (index) {
                              TaskModel taskModel = tasks[index];
                              return TaskItemView(
                                onStatusUpdate: () async {
                                  await LocalDatabase.updateTaskStatus(
                                    newStatus: "completed",
                                    taskId: taskModel.id!,
                                  );
                                  _init();
                                },
                                taskModel: taskModel,
                                onDelete: () async {
                                  int d = await LocalDatabase.deleteTask(
                                      taskModel.id!);
                                  _init();
                                },
                                onUpdate: () {
                                  addTaskDialog(
                                    context: context,
                                    taskModelChanged: (updatedTask) async {
                                      await LocalDatabase.updateTask(
                                        updatedTask.copyWith(id: taskModel.id),
                                        taskModel.id!,
                                      );
                                      _init();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
