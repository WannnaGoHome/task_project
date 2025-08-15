import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practise/domain/entities/task.dart';
import 'package:practise/ui/screens/change_profile/change_profile_screen.dart';
import 'package:practise/ui/screens/numbers/num_screen.dart';
import 'package:practise/ui/screens/task/comp_tasks_detailed_navigator.dart';
import 'package:practise/ui/screens/task/task_screen.dart';
import 'package:practise/ui/screens/task/task_tabs_wrapper.dart';
import 'package:practise/ui/screens/task/act_tasks_detailed_navigator.dart';
import '../../ui/screens/profile/profile_screen.dart';
import '../../ui/screens/task/taskinfo_screen.dart';
import '../../ui/screens/authorization/authorization_screen.dart';

part "./task_router.gr.dart";

@RoutePage(name: 'ActiveTaskRoute')
class ActiveTaskScreen extends TaskScreen {
  const ActiveTaskScreen({super.key}) : super(showCompleted: false);
}

@RoutePage(name: 'CompletedTaskRoute')
class CompletedTaskScreen extends TaskScreen {
  const CompletedTaskScreen({super.key}) : super(showCompleted: true);
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: AuthorizationRoute.page, 
          initial: true, path: '/'),
    AutoRoute(
          page: TaskTabsWrapperRoute.page,
          path: '/mainscreen',
          children: [
            AutoRoute(page:  ActDetailedNavigatorRoute.page, children: [
              AutoRoute(page: ActiveTaskRoute.page, path: 'active', initial: true,),
              AutoRoute(page: TaskInfoRoute.page, path: 'task-info'),
            ]),
            AutoRoute(page: CompDetailedNavigatorRoute.page, children: [
              AutoRoute(page: CompletedTaskRoute.page, path: 'completed', initial: true,),
              AutoRoute(page: TaskInfoRoute.page, path: 'task-info'),
            ])
            

          ],
    ),
    AutoRoute(page: ChangeProfileRoute.page, path: '/change-profile'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: NumbersRoute.page, path: '/numbers'),
  ];
}