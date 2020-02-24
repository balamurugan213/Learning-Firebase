import 'package:c1/model/Movie.dart';
import 'package:flutter/material.dart';

class MovieTitle extends StatelessWidget {
  
  final Movie movie;
  MovieTitle({this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsetsDirectional.fromSTEB(20.0, 6.0, 20.0,0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.yellow[movie.strength],
            backgroundImage: AssetImage('assets/logo.png'),
          ),
          title: Text(movie.name),
          subtitle: Text('points:${movie.sugars}'),
        ),
      ),
    );
  }
}


