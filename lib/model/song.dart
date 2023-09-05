import 'dart:ui';

class Song {
  final String artist;
  final String title;
  final String art;
  final int duration;
  bool isFavorite;
  final String lyrics;
  late bool isActive = false;
  late List<Color> colors = [];

  Song(this.artist, this.title, this.duration, this.isFavorite, this.lyrics,
      this.art);

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      json['artist'] as String,
      json['title'] as String,
      json['duration'] as int,
      json['isFavorite'] as bool,
      json['lyrics'] as String,
      json['art'] as String,
    );
  }
}
