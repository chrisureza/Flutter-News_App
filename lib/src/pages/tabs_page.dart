import 'package:flutter/material.dart';
import 'package:flutter_news_provider/src/pages/tab1_page.dart';
import 'package:flutter_news_provider/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
      ],
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (index) => navigationModel.currentPage = index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          title: Text('Top News'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          title: Text('Categories'),
        ),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    this._currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
