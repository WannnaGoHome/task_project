// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'task_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ActDetailedNavigatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActDetailedNavigatorScreen(),
      );
    },
    ActiveTaskRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActiveTaskScreen(),
      );
    },
    AuthorizationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthorizationScreen(),
      );
    },
    ChangeProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ChangeProfileRouteArgs>(
          orElse: () =>
              ChangeProfileRouteArgs(userId: pathParams.optString('userId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChangeProfileScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    CompDetailedNavigatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CompDetailedNavigatorScreen(),
      );
    },
    CompletedTaskRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CompletedTaskScreen(),
      );
    },
    NumbersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NumbersScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    TaskInfoRoute.name: (routeData) {
      final args = routeData.argsAs<TaskInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskInfoScreen(
          key: args.key,
          task: args.task,
        ),
      );
    },
    TaskRoute.name: (routeData) {
      final args =
          routeData.argsAs<TaskRouteArgs>(orElse: () => const TaskRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TaskScreen(
          key: args.key,
          showCompleted: args.showCompleted,
        ),
      );
    },
    TaskTabsWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TaskTabsWrapper(),
      );
    },
    WebviewRoute.name: (routeData) {
      final args = routeData.argsAs<WebviewRouteArgs>(
          orElse: () => const WebviewRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WebviewScreen(
          key: args.key,
          wmFactory: args.wmFactory,
        ),
      );
    },
  };
}

/// generated route for
/// [ActDetailedNavigatorScreen]
class ActDetailedNavigatorRoute extends PageRouteInfo<void> {
  const ActDetailedNavigatorRoute({List<PageRouteInfo>? children})
      : super(
          ActDetailedNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActDetailedNavigatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ActiveTaskScreen]
class ActiveTaskRoute extends PageRouteInfo<void> {
  const ActiveTaskRoute({List<PageRouteInfo>? children})
      : super(
          ActiveTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActiveTaskRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthorizationScreen]
class AuthorizationRoute extends PageRouteInfo<void> {
  const AuthorizationRoute({List<PageRouteInfo>? children})
      : super(
          AuthorizationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthorizationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangeProfileScreen]
class ChangeProfileRoute extends PageRouteInfo<ChangeProfileRouteArgs> {
  ChangeProfileRoute({
    Key? key,
    String? userId,
    List<PageRouteInfo>? children,
  }) : super(
          ChangeProfileRoute.name,
          args: ChangeProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
          initialChildren: children,
        );

  static const String name = 'ChangeProfileRoute';

  static const PageInfo<ChangeProfileRouteArgs> page =
      PageInfo<ChangeProfileRouteArgs>(name);
}

class ChangeProfileRouteArgs {
  const ChangeProfileRouteArgs({
    this.key,
    this.userId,
  });

  final Key? key;

  final String? userId;

  @override
  String toString() {
    return 'ChangeProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [CompDetailedNavigatorScreen]
class CompDetailedNavigatorRoute extends PageRouteInfo<void> {
  const CompDetailedNavigatorRoute({List<PageRouteInfo>? children})
      : super(
          CompDetailedNavigatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompDetailedNavigatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CompletedTaskScreen]
class CompletedTaskRoute extends PageRouteInfo<void> {
  const CompletedTaskRoute({List<PageRouteInfo>? children})
      : super(
          CompletedTaskRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompletedTaskRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NumbersScreen]
class NumbersRoute extends PageRouteInfo<void> {
  const NumbersRoute({List<PageRouteInfo>? children})
      : super(
          NumbersRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumbersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TaskInfoScreen]
class TaskInfoRoute extends PageRouteInfo<TaskInfoRouteArgs> {
  TaskInfoRoute({
    Key? key,
    required Task task,
    List<PageRouteInfo>? children,
  }) : super(
          TaskInfoRoute.name,
          args: TaskInfoRouteArgs(
            key: key,
            task: task,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskInfoRoute';

  static const PageInfo<TaskInfoRouteArgs> page =
      PageInfo<TaskInfoRouteArgs>(name);
}

class TaskInfoRouteArgs {
  const TaskInfoRouteArgs({
    this.key,
    required this.task,
  });

  final Key? key;

  final Task task;

  @override
  String toString() {
    return 'TaskInfoRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [TaskScreen]
class TaskRoute extends PageRouteInfo<TaskRouteArgs> {
  TaskRoute({
    Key? key,
    bool showCompleted = false,
    List<PageRouteInfo>? children,
  }) : super(
          TaskRoute.name,
          args: TaskRouteArgs(
            key: key,
            showCompleted: showCompleted,
          ),
          initialChildren: children,
        );

  static const String name = 'TaskRoute';

  static const PageInfo<TaskRouteArgs> page = PageInfo<TaskRouteArgs>(name);
}

class TaskRouteArgs {
  const TaskRouteArgs({
    this.key,
    this.showCompleted = false,
  });

  final Key? key;

  final bool showCompleted;

  @override
  String toString() {
    return 'TaskRouteArgs{key: $key, showCompleted: $showCompleted}';
  }
}

/// generated route for
/// [TaskTabsWrapper]
class TaskTabsWrapperRoute extends PageRouteInfo<void> {
  const TaskTabsWrapperRoute({List<PageRouteInfo>? children})
      : super(
          TaskTabsWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'TaskTabsWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WebviewScreen]
class WebviewRoute extends PageRouteInfo<WebviewRouteArgs> {
  WebviewRoute({
    Key? key,
    WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
            BuildContext)
        wmFactory = defaultWebviewWidgetModelFactory,
    List<PageRouteInfo>? children,
  }) : super(
          WebviewRoute.name,
          args: WebviewRouteArgs(
            key: key,
            wmFactory: wmFactory,
          ),
          initialChildren: children,
        );

  static const String name = 'WebviewRoute';

  static const PageInfo<WebviewRouteArgs> page =
      PageInfo<WebviewRouteArgs>(name);
}

class WebviewRouteArgs {
  const WebviewRouteArgs({
    this.key,
    this.wmFactory = defaultWebviewWidgetModelFactory,
  });

  final Key? key;

  final WidgetModel<ElementaryWidget<IWidgetModel>, ElementaryModel> Function(
      BuildContext) wmFactory;

  @override
  String toString() {
    return 'WebviewRouteArgs{key: $key, wmFactory: $wmFactory}';
  }
}
