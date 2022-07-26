import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/board_page_cubit/board_page_cubit.dart';
import 'package:todo/presentation/board/widget/all_tasks.dart';
import 'package:todo/presentation/board/widget/compelet_tasts.dart';
import 'package:todo/presentation/board/widget/favorite_tasks.dart';
import 'package:todo/presentation/board/widget/icon_button.dart';
import 'package:todo/presentation/board/widget/uncompelet_tasks.dart';
import '../../cubit/board_page_cubit/board_page_state.dart';
import '../adding_task/add_task_page.dart';
import '../schedule/schedule_page.dart';
import '../share_widget/button.dart';

class BoardPageScreen extends StatefulWidget {
  const BoardPageScreen({Key? key}) : super(key: key);

  @override
  State<BoardPageScreen> createState() => BoardPageScreenState();
}

class BoardPageScreenState extends State<BoardPageScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<BoardPageCubit, BoardPageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final controller = BoardPageCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Board",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              IconButtonItem(
                  icon: Icons.search_outlined, onPress: () {}, size: size),
              IconButtonItem(
                  icon: Icons.notifications_active_outlined,
                  onPress: () {},
                  size: size),
              IconButtonItem(
                  icon: Icons.schedule,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScheduleScreen()));
                  },
                  size: size),
            ],
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              controller: tabController,
              tabs: controller.homePageTabs,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TabBarView(controller: tabController, children: [
                    AllTasksItem(size: size),
                    CompeletedTasksItem(size: size),
                    UncompeletedTasksItem(size: size),
                    FavoriteTasksItem(size: size),
                  ]),
                ),
              ),
              ButtonItem(
                  head: "Add a task",
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddTaskScreen()));
                  },
                  size: size),
            ],
          ),
        );
      },
    );
  }
}
