import 'package:flutter/material.dart';

import '../widgets/AuthForm.dart';
import '../config/enums.dart';

class Auth extends StatefulWidget {

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Mode _authMode = Mode.Login;
  
  void _switchMode() {
    setState(() {
      _authMode = _authMode == Mode.Login ? Mode.Register : Mode.Login;
    });
  }

  @override
  Widget build (BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
             decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Medium',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 50,
                        fontFamily: 'Anton',
                        fontWeight: FontWeight.normal,
                      )
                    )
                  ),
                  Flexible(
                    flex: 2,
                    child: AuthForm(mode: _authMode),
                  ),
                  SizedBox(height: 10,),
                  FlatButton(
                    child: Text('${_authMode == Mode.Login ? 'Create a new account' : 'Already have an account'}'),
                    onPressed: _switchMode,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              )
            )
          ),
          
        ],
      )
    );
  }
}