import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/articles.dart';
import './ArticleItem.dart';

class Articles extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final articlesData = Provider.of<ArticlesProvider>(context);
    final articles = articlesData.list;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: articles.length,
        itemBuilder: (ctx, i) => ArticleItem(articles[i]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}