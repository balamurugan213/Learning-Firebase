//import 'dart:html';

import 'package:c1/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:c1/screens/authenticate/signin.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn=true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView:toggleView);
    }
    else{
      return Register(toggleView:toggleView);
    }
  }
}
