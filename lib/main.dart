import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/push_usecases_demo.dart';
import 'package:go_router_example/test_pop_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Flutter Demo',
    );
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
        title: Text("Home page"),
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
                  child: Text('push usecases')),
              ElevatedButton(
                  onPressed: () {
                    context.push('/test_pop_util');
                  },
                  child: Text('Test pop util')),
            ],
          ),
        ),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
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
  ],
);
