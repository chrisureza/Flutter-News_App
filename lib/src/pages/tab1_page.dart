import 'package:flutter/material.dart';
import 'package:flutter_news_provider/src/widgets/news_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_news_provider/src/services/news_service.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: (newsService.headlines.length == 0)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : NewsList(
                news: newsService.headlines,
              ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
