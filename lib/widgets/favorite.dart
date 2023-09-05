import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cubit_store/song.dart';

class FavoriteBar extends StatefulWidget {
  const FavoriteBar({Key? key}) : super(key: key);

  @override
  FavoriteBarState createState() => FavoriteBarState();
}

class FavoriteBarState extends State<FavoriteBar> {
  @override
  Widget build(BuildContext context) {
    var songCubit = context.watch<SongCubit>();
    var activeSong = songCubit.getActiveSong();
    bool isFavorite = activeSong.isFavorite;

    return IconButton(
      onPressed: () {
        setState(() {
          songCubit.toggleFavoriteForSong(activeSong);
          var msg =
              !isFavorite ? 'Added to favorites' : 'Removed from favorites';
          var snackBar = SnackBar(
            content: Text(msg),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      icon: Icon(
        !isFavorite ? Icons.favorite_border : Icons.favorite,
        color: !isFavorite ? Colors.white : Colors.green,
        size: 38,
      ),
    );
  }
}
