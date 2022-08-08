import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/my_app_bar.dart';

class RefreshAndBackToPreviousPageUsecaseDemo extends StatelessWidget {
  const RefreshAndBackToPreviousPageUsecaseDemo({
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
                context.goNamed(
                  'RefreshAndBackToPreviousPageUsecaseDemoPage1',
                  queryParams: {"shouldBackToPreviousPage": '0'},
                );
              },
              child: const Text(
                  'Go to RefreshAndBackToPreviousPageUsecaseDemoPage1')),
        ],
      ),
    );
  }
}

class RefreshAndBackToPreviousPageUsecaseDemoPage1 extends StatefulWidget {
  const RefreshAndBackToPreviousPageUsecaseDemoPage1({
    Key? key,
  }) : super(key: key);

  @override
  State<RefreshAndBackToPreviousPageUsecaseDemoPage1> createState() =>
      _RefreshAndBackToPreviousPageUsecaseDemoPage1State();
}

class _RefreshAndBackToPreviousPageUsecaseDemoPage1State
    extends State<RefreshAndBackToPreviousPageUsecaseDemoPage1> {
  String shouldBackToPreviousPage = '';

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final shouldBackToPreviousPage =
          arguments['shouldBackToPreviousPage'] ?? '0';

      if (shouldBackToPreviousPage == '1') {
        context.goNamed('RefreshAndBackToPreviousPageUsecaseDemo');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Text(
              'Refresh this page - shouldBackToPreviousPage $shouldBackToPreviousPage'),
        ],
      ),
    );
  }
}
