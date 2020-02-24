import 'package:c1/model/shared/constant.dart';
import 'package:c1/model/shared/loding.dart';
import 'package:c1/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:c1/model/user.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {


  final _formkey= GlobalKey<FormState>();
  final List<String> sugar =['0','1','2','3','4'];
  //formvalue
  String _currentName;
  String _currentSugar;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {

        UserData userData = snapshot.data;

        if(snapshot.hasData){
        return Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              Text('Update the Details',
              style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height:20.0,),
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) =>val.isEmpty ?'Please enter name' :null,
                onChanged: (val) =>setState(() => _currentName = val),
              ),
              SizedBox(height: 20.0,),
              //dropDown
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentSugar ?? userData.sugars,
                items: sugar.map((sugar){
                  return DropdownMenuItem(
                  
                    value: sugar,
                    child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) =>setState(() => _currentSugar = val),
              ),
              Slider(
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.yellow[_currentStrength ?? userData.strength],
                inactiveColor: Colors.white,
                
                min: 100,
                max: 900,
                divisions: 8,
                onChanged:(val) =>setState(() => _currentStrength = val.round()),
               ),
              SizedBox(height: 10.0,),
              //slider
              RaisedButton(
                color: Colors.yellow[600],
                child: Text(
                  'update',
                   style: TextStyle(color: Colors.white)
                ),
                onPressed: () async{
                  if(_formkey.currentState.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                      _currentSugar ?? userData.sugars, 
                      _currentName ?? userData.strength,
                      _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                  }


                },
              )
            ],

          ),
          
        );
        }
        else
        {
          return Loading();

        }
      }
    );
  }
}