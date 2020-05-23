import 'package:flutter/material.dart';
import 'package:flutter_news_provider/src/models/category_model.dart';
import 'package:flutter_news_provider/src/services/news_service.dart';
import 'package:flutter_news_provider/src/theme/theme.dart';
import 'package:flutter_news_provider/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            _CategoryList(),
            Expanded(
              child: newsService.getSelectedCategoryArticles.length == 0
                  ? Center(child: CircularProgressIndicator())
                  : NewsList(news: newsService.getSelectedCategoryArticles),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      height: 130,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: _CategoryButton(categories[index]),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    // final itemName = category.name;
    return GestureDetector(
      onTap: () {
        newsService.seletedCategory = category.name;
      },
      child: Container(
        width: 90,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: newsService.seletedCategory == category.name
                    ? myTheme.accentColor
                    : Colors.white70,
              ),
              child: Icon(
                category.icon,
                color: newsService.seletedCategory == category.name
                    ? Colors.white70
                    : Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              category.alias,
              style: TextStyle(
                color: newsService.seletedCategory == category.name
                    ? myTheme.accentColor
                    : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
