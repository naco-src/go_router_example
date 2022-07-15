import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/error_screen.dart';
import 'package:go_router_example/login_screen.dart';
import 'package:go_router_example/state.dart';
import 'package:go_router_example/params_queryparams_usecases_demo.dart';
import 'package:go_router_example/push_usecases_demo.dart';
import 'package:go_router_example/test_pop_util.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late final AuthState? authState;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthState>(
      future: _getLoginInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        authState = snapshot.data;
        return ChangeNotifierProvider<AuthState?>.value(
          value: authState,
          builder: (context, child) {
            return MaterialApp.router(
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              title: 'Flutter Demo',
            );
          },
        );
      },
    );
  }

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
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
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: authState,
    redirect: (state) {
      final loggedIn = authState?.stateEnum == AuthStateEnum.authenticated;
      final loggingIn = state.subloc == '/login';

      final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
      if (!loggedIn) return loggingIn ? null : '/login$fromp';
      if (loggingIn) return state.queryParams['from'] ?? '/';
      return null;
    },
  );

  Future<AuthState> _getLoginInfo() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    final authState = AuthState();
    authState.setAuthStatus(AuthStateEnum.authenticated);
    return authState;
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed('pushUsecaseDemoScreen');
                  },
                  child: const Text('push usecases')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/test_pop_util');
                  },
                  child: const Text('Test pop util')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed('QueryParamsUsecaseDemoScreen');
                  },
                  child: const Text('go QueryParamsUsecaseDemoScreen')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    context.push('/notfound');
                  },
                  child: const Text('Dummy page')),
            ],
          ),
        ),
      ),
    );
  }
}
