import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/now_playing_info.dart';

class NowPlayingCubit extends Cubit<NowPlayingInfo> {
  NowPlayingCubit()
      : super(NowPlayingInfo(
          volume: 0.5,
          isPlaying: false,
          isShuffle: false,
          isRepeat: false,
          currentSongIndex: 0,
        ));

  get isPlaying => state.isPlaying;

  void togglePlayPause() {
    NowPlayingInfo currentInfo = state;
    currentInfo.isPlaying = !currentInfo.isPlaying;
    emit(currentInfo);
  }

  void setVolume(double volume) {
    NowPlayingInfo currentInfo = state;
    currentInfo.volume = volume;
    emit(currentInfo);
  }

  getVolume() {
    return state.volume;
  }
}
