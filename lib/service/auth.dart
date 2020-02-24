import 'package:c1/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:c1/model/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //User u1=new User();

  //create User object
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }
  

  //auth change in stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser(user));
  }
  

  //sign in anon
  Future signInAnon () async{
    try{
      AuthResult result=  await  _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign in wit id
  Future signInWithEmailPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }


  //register
  Future registerWithEmailPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
      FirebaseUser user=result.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);

    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign out
  Future SignOut() async{
    try{
      return await _auth.signOut();

    }
    catch(e){
      print(e.toString());
      return null;

    }
    
  }


}


