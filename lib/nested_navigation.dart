import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/my_app_bar.dart';

class NestedNavigationScreen extends StatefulWidget {
  const NestedNavigationScreen({Key? key, required this.tabIndex})
      : super(key: key);
  final int tabIndex;
  @override
  State<NestedNavigationScreen> createState() => _NestedNavigationScreenState();
}

class _NestedNavigationScreenState extends State<NestedNavigationScreen> {
  @override
  void didUpdateWidget(NestedNavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: widget.tabIndex,
            onDestinationSelected: (int index) {
              context.go('/nested_navigation/$index');
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('First'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Second'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.star_border),
                selectedIcon: Icon(Icons.star),
                label: Text('Third'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: Text('selectedIndex: ${widget.tabIndex}'),
            ),
          )
        ],
      ),
    );
  }
}
