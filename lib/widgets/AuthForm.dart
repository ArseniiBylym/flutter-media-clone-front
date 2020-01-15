import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../config/enums.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key key,
    @required this.mode
  }) : super(key: key);

  final Mode mode;

  @override 
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'password_confirm': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();


  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (widget.mode == Mode.Login) {
        await Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        await Provider.of<AuthProvider>(context, listen: false).register(
          _authData['name'],
          _authData['email'],
          _authData['password'],
          _authData['password_confirm'],
        );
      }
      Navigator.of(context).pushNamed('/');
    } catch (err) {
      const errorMessage = 'Authentification failed. Try again later';
      _showErrorDialog(errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        // height: 800,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form( 
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (widget.mode == Mode.Register) 
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      _authData['name'] = value;
                    },
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                 if (widget.mode == Mode.Register) 
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirm password'),
                    obscureText: true,
                    onSaved: (value) {
                      _authData['password_confirm'] = value;
                    },
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Password do not match';
                      }
                    },
                  ),
                SizedBox(height: 20),
                if (_isLoading) 
                  CircularProgressIndicator()
                else 
                  RaisedButton(
                    child: Text(widget.mode == Mode.Login ? 'Login' : 'Register'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                
                
              ],
            )
          )
        )
      ),
    );
  }
}