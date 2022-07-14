import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/my_app_bar.dart';

class PushUsecaseDemo extends StatelessWidget {
  const PushUsecaseDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          ///The push method is used to push a single page onto the stack of existing pages, which means that you can build up the stack programmatically instead of declaratively.
          ///When the push method matches an entire stack via sub-routes, it will take the top-most page from the stack and push that page onto the stack.
          const Text(
              "The push method is used to push a single page onto the stack of existing pages, which means that you can build up the stack programmatically instead of declaratively.When the push method matches an entire stack via sub-routes, it will take the top-most page from the stack and push that page onto the stack."),
          ElevatedButton(
              onPressed: () {
                context.pushNamed('PushDemoPage1');
              },
              child: const Text('Push to PushDemoPage1')),

          ///The go method does this by turning a single location into any number of pages in a stack using sub-routes.
          const Text(
              'The go method does this by turning a single location into any number of pages in a stack using sub-routes.'),
          ElevatedButton(
              onPressed: () {
                context.goNamed('PushDemoPage2');
              },
              child: const Text('Go to PushDemoPage2(pushReplacementNamed)')),

          ElevatedButton(
              onPressed: () {
                context.goNamed('CourseScreen');
              },
              child: const Text('Go to /pushUsecaseDemo/courses')),
          ElevatedButton(
              onPressed: () {
                context.pushNamed('CourseScreen');
              },
              child: const Text('Push to /pushUsecaseDemo/courses')),
        ],
      ),
    );
  }
}

class PushDemoPage1 extends StatelessWidget {
  const PushDemoPage1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Text(GoRouter.of(context).location),
    );
  }
}

class PushDemoPage2 extends StatelessWidget {
  const PushDemoPage2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Text(GoRouter.of(context).location),
    );
  }
}

class CourseScreen extends StatelessWidget {
  const CourseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Text(GoRouter.of(context).location),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).navigator?.popUntil(
                    (route) => route.settings.name == 'pushUsecaseDemoScreen');
              },
              child: Text('pop until pushUsecaseDemo screen')),
        ],
      ),
    );
  }
}
