import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_store/song.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    var color = context.watch<SongCubit>().getActiveSong().colors[2];
    return Card(
        margin: const EdgeInsets.fromLTRB(0, 24, 0, 24),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'About the artist',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Circular',
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
