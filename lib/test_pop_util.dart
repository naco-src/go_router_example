import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPopUtil extends StatelessWidget {
  const TestPopUtil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestPopUtil'),
      ),
      body: ElevatedButton(
        onPressed: () => context.push('/page2'),
        child: const Text('go to second page!!!'),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('second page'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/page3');
              },
              child: const Text('push - page 3'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text('back to home!!!'),
            ),
          ],
        ));
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('page 3'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).push('/page4');
            },
            child: const Text('push - page 4'),
          ),
          ElevatedButton(
            onPressed: () {
              GoRouter.of(context).go('/');
            },
            child: const Text('back to home!!!'),
          ),
        ],
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('page 4'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .navigator
                    ?.popUntil((route) => route.settings.name == 'page2');
              },
              child: const Text('pop until page2!!!'),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .navigator
                    ?.popUntil((route) => route.isFirst);
              },
              child: const Text('pop to first!!!'),
            ),
          ],
        ));
  }
}
