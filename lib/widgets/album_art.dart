import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_faux/cubit_store/song.dart';
import 'package:spotify_faux/widgets/favorite.dart';

class AlbumArt extends StatefulWidget {
  const AlbumArt({super.key});

  @override
  State<AlbumArt> createState() => _AlbumArtState();
}

class _AlbumArtState extends State<AlbumArt> {
  String sentenceCaseString(String input) {
    if (input.isEmpty) {
      return '';
    }
    return input
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    var songCubit = context.watch<SongCubit>();
    var activeSong = songCubit.getActiveSong();
    if (activeSong.title == '') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 38, 0, 38),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image(
              image: NetworkImage(
                activeSong.art,
              ),
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 250,
                      child: Text(
                        sentenceCaseString(activeSong.title),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      sentenceCaseString(activeSong.artist),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Column(
                      children: [
                        FavoriteBar(),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
