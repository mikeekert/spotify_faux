import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/song.dart';

class SongColor {
  final Color light;
  final Color dark;
  final Color bright;
  final Song song;

  SongColor(this.light, this.dark, this.bright,  this.song);
}

class SongCubit extends Cubit<List<Song>> {
  SongCubit() : super([]);

  void setSongActive(Song song) {
    final List<Song> currentSongs = [...state];
    for (var element in currentSongs) {
      if (element == song) {
        element.isActive = true;
      } else {
        element.isActive = false;
      }
    }
    emit(currentSongs);
  }

  void toggleFavoriteForSong(Song song) {
    List<Song> currentSongs = [...state];
    for (var element in currentSongs) {
      if (element == song) {
        element.isFavorite = !element.isFavorite;
      }
    }
    emit(currentSongs);
  }

  Song getActiveSong() {
    List<Song> currentSongs = [...state];
    return currentSongs.firstWhere((element) => element.isActive);
  }

  void setSongList(List<dynamic> song) {
    List<Song>? currentSong = [...state];
    currentSong = song.cast<Song>();
    emit(currentSong);
  }

  List<Song> get songsList => state;

  void setColors(List<Color> colors, Song song) {
    var currentSongs = [...state];
    var curr = currentSongs.firstWhere((element) => element == song);
    curr.colors = colors;
    emit(currentSongs);
  }

  void nextSong() {
    List<Song> currentSongs = state;
    int index =
        currentSongs.indexOf(state.firstWhere((element) => element.isActive));
    if (index == currentSongs.length - 1) {
      index = 0;
    } else {
      index++;
    }
    setSongActive(currentSongs[index]);
  }
}
