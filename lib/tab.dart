import 'package:flutter/material.dart';

import 'pages/events_example.dart';

class MyTabWidget extends StatefulWidget {
  const MyTabWidget(Set<Key?> set, {super.key});

  @override
  State<MyTabWidget> createState() => _MyTabWidgetState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyTabWidgetState extends State<MyTabWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Widget'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.home_outlined),
            ),
            Tab(
              icon: Icon(Icons.calendar_month_outlined),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Text("Home Page Here"),
          ),
          TableEventsExample()
        ],
      ),
    );
  }
}
