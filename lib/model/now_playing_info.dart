class NowPlayingInfo {
  double volume;
  bool isPlaying;
  bool isShuffle;
  bool isRepeat;
  int currentSongIndex;

  NowPlayingInfo({
    required this.volume,
    required this.isPlaying,
    required this.isShuffle,
    required this.isRepeat,
    required this.currentSongIndex,
  });
}
