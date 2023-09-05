import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_store/song.dart';

class LyricBox extends StatefulWidget {
  const LyricBox({
    super.key,
  });

  @override
  State<LyricBox> createState() => _LyricBoxState();
}

class _LyricBoxState extends State<LyricBox> {

  @override
  Widget build(BuildContext context) {
    var songCubit = context.watch<SongCubit>();
    var song = songCubit.getActiveSong();
    var colorLyric = song.colors[2];

    return SizedBox(
        height: 200,
        child: DecoratedBox(
            decoration: BoxDecoration(
                color: colorLyric,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(scrollDirection: Axis.vertical, children: const [
                Text("Lyrics",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Text(
                    'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, height: 2)),
                Text(
                  'Cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est.',
                  style:
                      TextStyle(color: Colors.black, fontSize: 16, height: 2),
                )
              ]),
            )));
  }
}
