import '../constants.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatefulWidget {
  LogoutScreen();
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  Widget _buildText() {
    return Column(
      children: <Widget>[
        Text(
          'You are now Logged Out.',
          style: TextStyle(
            fontFamily: 'Lato Bold',
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Thank You for using CookNotes!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato Bold',
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.asset("assets/cooknotes2.png"),
          height: 400,
          width: 300,
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, loginRoute, (_) => false);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xff00556A),
        child: Text(
          'Back to Login',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontFamily: 'Lato Bold',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildImage(),
                    _buildText(),
                    _buildLoginBtn(),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
