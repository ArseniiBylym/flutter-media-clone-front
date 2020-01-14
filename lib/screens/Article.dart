import 'package:flutter/material.dart';
import 'package:flutter_medium_clone_front/widgets/CustomDrawer.dart';
import 'package:provider/provider.dart';

import '../providers/articles.dart';
import '../models/Article.dart';
import '../widgets/CustomDrawer.dart';

class Article extends StatefulWidget {
  ArticleState createState() => ArticleState();
}

class ArticleState extends State<Article> {
  var _isInit = true;
  var _isLoading = true;
  ArticleModel _item;

  @override
  void didChangeDependencies() async {
    try {
      if (!_isInit) return;
      final id = ModalRoute.of(context).settings.arguments as String;
      final res = await Provider.of<ArticlesProvider>(context).fetchItem(id);
      setState(() {
        _item = res != null ? res : null;
        _isLoading = false;
      });
      _isInit = false;
    } catch (err) {
      throw (err);
    }
    super.didChangeDependencies();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article')
      ),
      drawer: CustomDrawer(),
      body: _isLoading 
        ? Center(
            child: CircularProgressIndicator()
          )
        : _item != null 
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      _item.image,
                      fit: BoxFit.cover
                    )
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Text(
                      _item.title,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )
                  )
                ],
              )
            )
          : Center(
              child: Text('Articles list is empty for now')
            )
    );
  }
}