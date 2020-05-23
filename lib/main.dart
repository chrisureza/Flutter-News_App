import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_provider/src/pages/full_article.dart';
import 'package:flutter_news_provider/src/pages/tabs_page.dart';
import 'package:flutter_news_provider/src/services/news_service.dart';
import 'package:flutter_news_provider/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor:
            (Platform.isAndroid) ? Colors.transparent : Colors.white));

    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NewsService())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: myTheme,
          initialRoute: 'home',
          routes: {
            'home': (BuildContext context) => TabsPage(),
            'full-article': (BuildContext context) => FullArticle(),
          }),
    );
  }
}
