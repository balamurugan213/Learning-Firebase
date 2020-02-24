
import 'package:c1/model/user.dart';
import 'package:c1/screens/authenticate/authenticate.dart';
import 'package:c1/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user);

    //home or authenticate
   // return Authenticate();

   if (user == null){
     return Authenticate();
   }
   else{
     return Home();
   }
      
    
  }
}