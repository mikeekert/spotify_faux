import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_faux/cubit_store/song.dart';
import 'package:spotify_faux/pages/device_settings.dart';

enum Repeat { off, one, all }

class SongControls extends StatefulWidget {
  const SongControls({Key? key}) : super(key: key);

  @override
  State<SongControls> createState() => _SongControlsState();
}

class _SongControlsState extends State<SongControls> {
  String convertSecondsToReadable(int input) {
    int seconds = input;
    int minutes = (seconds / 60).floor();
    seconds = seconds - (minutes * 60);
    String minutesString = minutes.toString();
    String secondsString = seconds.toString();
    if (minutes < 10) {
      minutesString = minutesString;
    }
    if (seconds < 10) {
      secondsString = '0$secondsString';
    }
    return '$minutesString:$secondsString';
  }

  void pause() {
    setState(() {
      isPlaying = false;
    });
    timer.cancel();
  }

  void play(int dur) {
    if (isPlaying) return;

    setState(() {
      isPlaying = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (currentTime < dur) {
          setState(() {
            currentTime++;
          });
        } else {
          if (isRepeat == Repeat.one || isRepeat == Repeat.all) {
            if (singleRepeat) {
              singleRepeat = false;
              isRepeat = Repeat.off;
            }
            currentTime = 0;
          } else {
            timer.cancel();
            pause();
            currentTime = 0;
          }
        }
      });
    });
  }

  int currentTime = 12;
  bool isPlaying = false;
  bool isShuffle = false;
  Repeat isRepeat = Repeat.off;
  bool singleRepeat = false;
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    var songCubit = context.watch<SongCubit>();
    var dur = songCubit.getActiveSong().duration;

    void nextSong() {
      setState(() {
        currentTime = 0;
      });
      songCubit.nextSong();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 24, 6, 0),
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Slider(
                    activeColor: Colors.white,
                    min: 0,
                    max: dur.toDouble(),
                    key: const Key('song_slider'),
                    value: currentTime.toDouble(),
                    inactiveColor: Colors.white.withOpacity(0.2),
                    onChanged: (newValue) =>
                        {setState(() => currentTime = newValue.toInt())})),
          ]),
        ),
        Row(
          children: [
            Text(
              convertSecondsToReadable(currentTime),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Text(
              convertSecondsToReadable(dur),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() => isShuffle = !isShuffle);
                },
                icon: Icon(
                  Icons.shuffle,
                  color: !isShuffle ? Colors.white : Colors.green,
                  size: 28,
                )),
            const Spacer(),
            IconButton(
                onPressed: () {
                  setState(() => currentTime = 0);
                },
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 38,
                )),
            const Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      pause();
                    } else {
                      play(dur);
                    }
                  });
                },
                icon: Icon(!isPlaying ? Icons.play_circle : Icons.pause_circle,
                    color: Colors.white, size: 58)),
            const Spacer(),
            IconButton(
              onPressed: () {
                nextSong();
              },
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 38,
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  setState(() => {
                        if (isRepeat == Repeat.off)
                          {
                            isRepeat = Repeat.one,
                            singleRepeat = true,
                          }
                        else if (isRepeat == Repeat.one)
                          {
                            isRepeat = Repeat.all,
                            singleRepeat = false,
                          }
                        else
                          {
                            isRepeat = Repeat.off,
                            singleRepeat = false,
                          }
                      });
                },
                icon: Icon(
                  setRepeatIcon(isRepeat),
                  color: isRepeat == Repeat.off ? Colors.white : Colors.green,
                  size: 28,
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeviceSettings()),
                    );
                  },
                  icon: const Icon(
                    Icons.speaker_group_outlined,
                    color: Colors.white,
                    size: 28,
                  )),
              const Spacer(),
              const Wrap(
                spacing: 42,
                children: [
                  Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.menu_open,
                    color: Colors.white,
                    size: 28,
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  IconData setRepeatIcon(isRepeat) {
    if (isRepeat == Repeat.off) {
      return Icons.repeat;
    } else if (isRepeat == Repeat.one) {
      return Icons.repeat_one;
    } else {
      return Icons.repeat;
    }
  }
}
