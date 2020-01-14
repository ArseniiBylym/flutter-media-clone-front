import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/articles.dart';
import '../widgets/Articles.dart';
import '../widgets/CustomDrawer.dart';

class Home extends StatefulWidget{
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var _isInit = true;
  var _isLoading = true;

  @override
  void didChangeDependencies() async {
    // if (!_isInit) return;
    // await Provider.of<ArticlesProvider>(context).fetch();
    // setState(() {
    //   _isLoading = false;
    // });
    // _isInit = false;
    // super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      drawer: CustomDrawer(),
      body: _isLoading
        ? Center(
            child: CircularProgressIndicator()
          )
        : Articles()
    );
  }
}