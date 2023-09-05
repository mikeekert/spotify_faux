import 'song.dart';

class Playlist {
  final String name;
  final List<dynamic> songs;

  Playlist(this.name, this.songs);

  // loop through json that has a List of playlists
  Playlist.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        songs = json['songs'].map((i) => Song.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'name': name,
        'songs': songs,
      };
}
