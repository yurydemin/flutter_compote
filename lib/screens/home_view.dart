import 'package:flutter/material.dart';
import 'package:flutter_compote/widgets/data_viewer.dart';
import 'package:flutter_compote/widgets/profile_viewer.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 0;

  _tabListener() {
    setState(() {
      _currentTabIndex = _tabController.index;
    });
  }

  _changeTab(int newIndex) {
    _tabController.index = newIndex;
    setState(() {
      _currentTabIndex = newIndex;
      _tabController.animateTo(_currentTabIndex);
    });
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(_tabListener);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _changeTab(0);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _changeTab,
          currentIndex: _currentTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq_outlined),
              label: 'Public',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            DataViewer(),
            ProfileViewer(),
          ],
        ),
      ),
    );
  }
}
