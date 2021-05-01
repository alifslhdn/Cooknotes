import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dependencies.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;

  final userDataService = UserRestService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xff00556A),
              fontFamily: 'Lato Bold',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xff00556A),
              ),
              hintText: 'Username',
              hintStyle: TextStyle(
                color: Color(0xff00556A),
                fontFamily: 'Lato',
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
            onSaved: (String value) {
              _username = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            validator: (String value) {
              if (value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
            onSaved: (String value) {
              _password = value;
            },
            obscureText: true,
            style: TextStyle(
              color: Color(0xff00556A),
              fontFamily: 'Lato Bold',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff00556A),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                color: Color(0xff00556A),
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print('Login Button Pressed');
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();

          print('Username: ' + _username);
          print('Password: ' + _password);

          bool correct = false;

          correct = await userDataService.login(_username, _password);

          if (correct == true) {
            Navigator.pushReplacementNamed(context, homeRoute);
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error "),
                    content: Text("Incorrect name or password"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          return;
                        },
                        child: Text("Back",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xff00556A),
                                fontFamily: 'Lato Black')),
                      ),
                    ],
                  );
                });
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xff00556A),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return Row(
      children: <Widget>[
        Text(
          '     Don\'t have an Account? ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        TextButton(
            child: Text(
              'Register',
              style: TextStyle(
                color: Color(0xff00556A),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, registerRoute);
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                // height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome To CookNotes!',
                        style: TextStyle(
                          color: Color(0xff00556A),
                          fontFamily: 'Lato Bold',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30.0),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildRegisterText(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
