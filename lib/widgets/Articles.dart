import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/articles.dart';
import './ArticleItem.dart';

class Articles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final articlesData = Provider.of<ArticlesProvider>(context);
    final articles = articlesData.list;
    return articles.length > 0 
      ? GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: articles.length,
          itemBuilder: (ctx, i) => ArticleItem(articles[i]),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 1,
          )
        )
      : Center(child: Text('Articles list is empty for now'),);
  }
}