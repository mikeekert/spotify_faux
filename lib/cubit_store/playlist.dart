import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/playlist.dart';

class PlaylistCubit extends Cubit<Playlist> {
  PlaylistCubit() : super(Playlist("", []));

  void setPlaylist(Playlist playlist) {
    Playlist currentPlaylist = state;
    currentPlaylist = playlist;
    emit(currentPlaylist);
  }

  Playlist get getPlayList => state;
}
