import 'package:flutter/material.dart';
import 'package:flutter_news_provider/src/models/category_model.dart';
import 'package:flutter_news_provider/src/models/news_models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:http/http.dart" as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = 'faf6b547093247e9b1a8da1a64cfa7fe';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _seletedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business', 'Business'),
    Category(FontAwesomeIcons.tv, 'entertainment', 'Entertain'),
    Category(FontAwesomeIcons.addressCard, 'general', 'General'),
    Category(FontAwesomeIcons.headSideVirus, 'health', 'Health'),
    Category(FontAwesomeIcons.vials, 'science', 'Science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports', 'Sports'),
    Category(FontAwesomeIcons.memory, 'technology', 'Technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
    getArticlesByCategory(seletedCategory);
  }

  get seletedCategory => this._seletedCategory;
  set seletedCategory(String value) {
    this._seletedCategory = value;
    this.getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getSelectedCategoryArticles =>
      this.categoryArticles[this.seletedCategory];

  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category].length > 0) {
      return categoryArticles[category];
    }
    final url =
        '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us&category=$category';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
