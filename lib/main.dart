import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify_faux/cubit_store/now_playing.dart';
import 'package:spotify_faux/cubit_store/playlist.dart';
import 'package:spotify_faux/cubit_store/song.dart';
import 'package:spotify_faux/model/playlist.dart';
import 'package:spotify_faux/widgets/album_art.dart';
import 'package:spotify_faux/widgets/header_bar.dart';
import 'package:spotify_faux/widgets/lyric_box.dart';
import 'package:spotify_faux/widgets/song_controls.dart';

import 'model/song.dart';
import 'services/playlist.service.dart';
import 'styles/custom_track_shape.dart';
import 'widgets/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => PlaylistCubit()),
        BlocProvider(create: (BuildContext context) => NowPlayingCubit()),
        BlocProvider(create: (BuildContext context) => SongCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Circular',
          sliderTheme: SliderThemeData(
            overlayShape: SliderComponentShape.noOverlay,
            trackShape: CustomTrackShape(),
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 5,
              elevation: 0,
              pressedElevation: 0,
            ),
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PaletteGenerator? paletteGenerator;

  Future<List<SongColor>> updatePaletteGenerator(List<Song> list) async {
    if (list.isEmpty) {
      return [];
    }

    List<SongColor> tList = [];

    for (var i = 0; i < list.length; i++) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(list[i].art),
        maximumColorCount: 150,
      );

      final hsl = HSLColor.fromColor(paletteGenerator!.dominantColor!.color);
      final hslDark =
      hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
      final hslBright = hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0));

      var obj = SongColor(
          hsl.toColor(),
          hslDark.toColor(),
          hslBright.toColor(),
          list[i]
      );
      tList.add(obj);
    }

    return tList;
  }

  @override
  initState() {
    super.initState();
    PlaylistService().getPlaylistForUser().then((Playlist playlist) {
      context.read<PlaylistCubit>().setPlaylist(playlist);
      context.read<SongCubit>().setSongList(playlist.songs);
      context.read<SongCubit>().setSongActive(playlist.songs.first);

      var list = context.read<SongCubit>().songsList;

      updatePaletteGenerator(list).then((colorData) {

        for (var i in colorData) {
          context.read<SongCubit>().setColors([i.light, i.dark, i.bright], i.song);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var songCubit = context.watch<SongCubit>();
    var listOfSongs = songCubit.songsList;

    if (listOfSongs.isEmpty || songCubit.getActiveSong().colors.isEmpty) {
      return const Center(
        widthFactor: 100,
        heightFactor: 100,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      );
    }

    var colors = songCubit.getActiveSong().colors;

    return Scaffold(
        // make the background color color (85, 0, 98) and use a gradient
        backgroundColor: Colors.black87,
        body: Container(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colors[0], colors[1]],
            ),
          ),
          child: SafeArea(
              child: ListView(scrollDirection: Axis.vertical, children: const [
            HeaderBar(),
            AlbumArt(),
            SongControls(),
            LyricBox(),
            About()
          ])),
        ));
  }
}
