import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './providers/articles.dart';
import './screens/Home.dart';
import './screens/Article.dart';
import './screens/Auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
         ChangeNotifierProvider.value(
          value: ArticlesProvider(),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Medium',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Lato'
          ),
          home: Home(),
          routes: {
            '/article': (ctx) => Article(),
            '/auth': (ctx) => Auth(),
          }
        ),
      ),
    );
  }
}
