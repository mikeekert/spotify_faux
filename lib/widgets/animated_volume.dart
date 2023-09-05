import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedVolume extends StatefulWidget {
  const AnimatedVolume({Key? key}) : super(key: key);

  @override
  State<AnimatedVolume> createState() => _AnimatedVolumeState();
}

class _AnimatedVolumeState extends State<AnimatedVolume> {
  List<int> heights = [5, 32, 5, 32];
  Timer? timer;

  timerCallback(Timer timer) {
    if (!mounted) {
      timer.cancel();
      return;
    }
    setState(() {
      heights = heights.map((int e) {
        return randomAdjustment(e);
      }).toList();
    });
  }

  int randomAdjustment(int e) {
    int minNum = max(e - 7, 1);
    int maxNum = min(e + 7, 32);

    // new height is between minNum and maxNum
    int newHeight = Random().nextInt(maxNum - minNum) + minNum;

    if (newHeight < 14) {
      newHeight = 14;
    }
    if (newHeight > 32) {
      newHeight = 32;
    }
    return newHeight;
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(const Duration(milliseconds: 100), timerCallback);

    return SizedBox(
      height: 32,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: 4,
            children: [
              for (var i = 0; i < heights.length; i++)
                AnimatedContainer(
                  width: 4,
                  height: heights[i].toDouble(),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.fastOutSlowIn,
                )
            ],
          )
        ],
      ),
    );
  }
}
