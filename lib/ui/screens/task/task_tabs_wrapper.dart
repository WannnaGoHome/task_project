// lib/ui/screens/task/task_tabs_wrapper.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practise/data/router/task_router.dart';

@RoutePage(name: 'TaskTabsWrapperRoute')
class TaskTabsWrapper extends StatelessWidget {
  const TaskTabsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
      return AutoTabsRouter.tabBar(
        routes: const [
          ActiveTaskRoute(),
          CompletedTaskRoute(),
        ],
        builder: (context, child, _) {
          
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
          appBar: AppBar(
                  backgroundColor: Colors.pink,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.numbers_outlined),
                      onPressed: () {
                        context.pushRoute(const NumbersRoute());
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        context.pushRoute(const ProfileRoute());
                      },
                    ),
                  ],
                ),
            body: child,
            
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'Активные',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: 'Завершённые',
                ),
              ],
            ),
          );
        },
      // ),
    );
  }
}