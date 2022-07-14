import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/my_app_bar.dart';

class QueryParamsUsecaseDemo extends StatelessWidget {
  const QueryParamsUsecaseDemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.goNamed('ListCourseScreen');
              },
              child: const Text('Go to /queryparamsusecasedemo/courses')),
          ElevatedButton(
              onPressed: () {
                context.goNamed('ListCourseScreen',
                    queryParams: {'name': 'Course 1'});
              },
              child: const Text(
                  'Go to /queryparamsusecasedemo/courses with query params')),
        ],
      ),
    );
  }
}

class ListCourseScreen extends StatelessWidget {
  const ListCourseScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Text(GoRouter.of(context).location),
          Text(arguments.toString()),
          ...List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).goNamed(
                      'CourseDetailScreen',
                      params: {'course_id': '$index'},
                    );
                  },
                  child: Text('Course $index')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed('CourseDetailScreen',
                      params: {'course_id': '4'});
                },
                child: Text('Course 4')),
          ),
        ],
      ),
    );
  }
}

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final courseId = arguments['course_id'] ?? '';
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Text(GoRouter.of(context).location),
          Text(arguments.toString()),
          ...List.generate(
              3,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .goNamed('LessonDetailsScreen', params: {
                            'course_id': courseId,
                            'lesson_id': '${index + int.parse(courseId)}',
                          });
                        },
                        child: Text('Lesson ${index + int.parse(courseId)}')),
                  )),
        ],
      ),
    );
  }
}

class LessonDetailsScreen extends StatelessWidget {
  const LessonDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Text(GoRouter.of(context).location),
          Text(ModalRoute.of(context)?.settings.arguments.toString() ??
              'do not know agruments'),
          ElevatedButton(
              onPressed: () {
                GoRouter.of(context).navigator?.popUntil(
                    (route) => route.settings.name == 'CourseDetailScreen');
              },
              child: Text('pop until CourseDetailScreen')),
        ],
      ),
    );
  }
}
