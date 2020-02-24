import 'package:c1/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:c1/model/Movie.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection referance
  final CollectionReference mcollection = Firestore.instance.collection("movie");

  Future updateUserData(String sugars,String name,int strength) async{
    return await mcollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength,
    });
  }

//movie list from dnapshot
List<Movie> _movieListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc){
    return Movie(
      name: doc.data['name'] ?? '',
      strength: doc.data['strength'] ?? 0,
      sugars: doc.data['sugars'] ?? '0'      
    );
  }).toList();
}


//user data from snapshot
UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    sugars: snapshot.data['sugars'],
    strength: snapshot.data['strength']
  );
}

//get stream
Stream<List<Movie>> get movie {
  return mcollection.snapshots()
  .map(_movieListFromSnapshot);
}

//get user doc
Stream<UserData> get userData {
  return  mcollection.document(uid).snapshots()
  .map(_userDataFromSnapShot);

}
}