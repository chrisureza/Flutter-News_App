import 'package:flutter/material.dart';
import 'package:flutter_news_provider/src/models/news_models.dart';
import 'package:flutter_news_provider/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList({this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _NewsItem(article: this.news[index], index: index);
      },
    );
  }
}

class _NewsItem extends StatelessWidget {
  final Article article;
  final int index;

  const _NewsItem({
    @required this.article,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _CardTopBar(article, index),
          _CardTitle(article),
          _CardImage(article),
          _CardBody(article),
          SizedBox(
            height: 15,
          ),
          _CardButtons(article),
          SizedBox(
            height: 10,
          ),
          Divider(),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article article;
  final int index;

  const _CardTopBar(this.article, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text('${index + 1}. ', style: TextStyle(color: myTheme.accentColor)),
          Text('${article.source.name}. '),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article article;

  const _CardTitle(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(article.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          )),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article article;

  const _CardImage(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: (article.urlToImage != null)
              ? FadeInImage(
                  placeholder: AssetImage('assets/img/giphy.gif'),
                  image: NetworkImage(article.urlToImage),
                )
              : Image(
                  image: AssetImage('assets/img/no-image.png'),
                ),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article article;

  const _CardBody(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((article.description != null) ? article.description : ''),
    );
  }
}

class _CardButtons extends StatelessWidget {
  final Article article;
  const _CardButtons(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // RawMaterialButton(
          //   onPressed: () {},
          //   fillColor: myTheme.accentColor,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Icon(Icons.star_border),
          // ),
          // SizedBox(
          //   width: 10.0,
          // ),
          RawMaterialButton(
            onPressed: () => _launchURL(article.url),
            fillColor: myTheme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.forward,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
