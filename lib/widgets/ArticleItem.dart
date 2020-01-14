import 'package:flutter/material.dart';

import '../models/Article.dart';

class ArticleItem extends StatelessWidget {
  ArticleModel article;
  ArticleItem(this.article);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              '/article',
              arguments: article.id
            );
          },
          child: Image.network(
            article.image,
            fit: BoxFit.cover,
          )
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            article.title,
            textAlign: TextAlign.center,
          )
        )
      )
    );
  }
}