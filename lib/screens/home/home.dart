import 'package:c1/model/Movie.dart';
import 'package:c1/screens/home/movie_list.dart';
import 'package:c1/screens/home/setting_form.dart';
import 'package:c1/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:c1/service/database.dart';


class Home extends StatefulWidget {
 @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth =AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanal(){
      showModalBottomSheet(context: context,builder:(context){
        return Container(
          color: Colors.yellow[100],
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm()
        );
      });
    }

    return StreamProvider<List<Movie>>.value(
        value: DatabaseService().movie,
        child: Scaffold(
        backgroundColor: Colors.yellow[50],
        appBar: AppBar(
          title: Text('yellow box'),
          backgroundColor: Colors.yellow[600],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async{
                await _auth.SignOut();

              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Setting'),
              onPressed: () =>_showSettingsPanal()
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/camera.png'),
            fit: BoxFit.cover,
            )
          ),
          child: Moviee()
          ),
      ),
    );
  }
}