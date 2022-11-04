import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/login_screen.dart';
import 'package:go_router_example/main.dart';
import 'package:go_router_example/nested_navigation.dart';
import 'package:go_router_example/refresh_and_back_to_previous.dart';
import 'package:go_router_example/params_queryparams_usecases_demo.dart';
import 'package:go_router_example/push_usecases_demo.dart';
import 'package:go_router_example/test_pop_util.dart';

final myGoRouterRoutes = <GoRoute>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const MyHomePage(),
      routes: [
        GoRoute(
          name: 'PushDemoPage1',
          path: 'PushDemoPage1',
          builder: (context, state) => const PushDemoPage1(),
        ),
        GoRoute(
          name: 'PushDemoPage2',
          path: 'PushDemoPage2',
          builder: (context, state) => const PushDemoPage2(),
        ),
        GoRoute(
            name: 'pushUsecaseDemoScreen',
            path: 'pushusecasedemo',
            builder: (context, state) => const PushUsecaseDemo(),
            routes: [
              GoRoute(
                name: 'CourseScreen',
                path: 'courses',
                builder: (context, state) => const CourseScreen(),
              ),
              GoRoute(
                name: 'PushDemoPage1x1',
                path: 'PushDemoPage1x1',
                builder: (context, state) => const PushDemoPage1(),
              ),
              GoRoute(
                name: 'PushDemoPage1x2',
                path: 'PushDemoPage1x2',
                builder: (context, state) => const PushDemoPage1(),
              ),
            ]),
        GoRoute(
            name: 'QueryParamsUsecaseDemoScreen',
            path: 'queryparamsusecasedemo',
            builder: (context, state) => const QueryParamsUsecaseDemo(),
            routes: [
              GoRoute(
                  name: 'ListCourseScreen',
                  path: 'courses',
                  builder: (context, state) => const ListCourseScreen(),
                  routes: [
                    GoRoute(
                        name: 'CourseDetailScreen',
                        path: ':course_id',
                        builder: (context, state) =>
                            const CourseDetailsScreen(),
                        routes: [
                          GoRoute(
                            name: 'LessonDetailsScreen',
                            path: 'lessons/:lesson_id',
                            builder: (context, state) =>
                                const LessonDetailsScreen(),
                          ),
                        ]),
                  ]),
            ]),
        GoRoute(
          name: 'CourseDetailsScreen2',
          path: 'queryparamsusecasedemo/courses/:course_id',
          builder: (context, state) => const CourseDetailsScreen(),
        ),
        GoRoute(
          path: 'nested_navigation',
          redirect: (context, state) => '/nested_navigation/0',
        ),
        GoRoute(
          path: 'nested_navigation/:tab_index',
          builder: (context, state) {
            final tabIndex = int.parse(state.params['tab_index']!);
            return NestedNavigationScreen(tabIndex: tabIndex);
          },
        ),
        GoRoute(
          name: 'RefreshAndBackToPreviousPageUsecaseDemo',
          path: 'refresh_and_back_demo',
          builder: (context, state) =>
              const RefreshAndBackToPreviousPageUsecaseDemo(),
          routes: [
            GoRoute(
              name: 'RefreshAndBackToPreviousPageUsecaseDemoPage1',
              path: 'page1',
              builder: (context, state) =>
                  const RefreshAndBackToPreviousPageUsecaseDemoPage1(),
            ),
          ],
        ),
      ]),
  GoRoute(
    name: 'test_pop_util',
    path: '/test_pop_util',
    builder: (context, state) => const TestPopUtil(),
  ),
  GoRoute(
    name: "page2",
    path: '/page2',
    builder: (context, state) => const SecondPage(),
  ),
  GoRoute(
    path: '/page3',
    builder: (context, state) => const ThirdPage(),
  ),
  GoRoute(
    path: '/page4',
    builder: (context, state) => const Page4(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
];
