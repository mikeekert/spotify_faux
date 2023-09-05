import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/octicons_icons.dart';

import '../cubit_store/playlist.dart';
import '../styles/styles.dart';

const chevronDown = Icon(LineariconsFree.chevron_down, color: Colors.white);
const kebabVertical = Icon(Octicons.kebab_vertical, color: Colors.white);

class HeaderBar extends StatefulWidget {
  const HeaderBar({
    super.key,
  });

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  @override
  Widget build(BuildContext context) {
    String playlistName = '';

    var cubitStore = context.watch<PlaylistCubit>();

    if (cubitStore.getPlayList.songs.isNotEmpty) {
      setState(() {
        playlistName = cubitStore.getPlayList.name;
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // make the text color white
        const Expanded(
          flex: 0,
          child: chevronDown,
        ),
        Expanded(
          flex: 0,
          child: Column(
            children: [
              Row(
                children: [
                  Text('playing from playlist'.toUpperCase(),
                      style: myTextStyle.copyWith(
                        fontSize: 12,
                        letterSpacing: 1.5,
                      )),
                ],
              ),
              Row(
                children: [
                  Text(playlistName,
                      style: myTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
            ],
          ),
        ),
        Expanded(
          flex: 0,
          child: IconButton(onPressed: () {}, icon: kebabVertical),
        ),
      ],
    );
  }
}
