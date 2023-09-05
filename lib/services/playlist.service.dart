import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:spotify_faux/model/playlist.dart';

class PlaylistService {
  Future<Playlist> getPlaylistForUser() async {
    String response = await rootBundle.loadString('assets/json/api_resp.json');
    Map<String, dynamic> userData = jsonDecode(response);

    Playlist pLists = Playlist.fromJson(userData);

    return pLists;
  }
}
