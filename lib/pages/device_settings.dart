import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit_store/now_playing.dart';
import '../widgets/animated_volume.dart';

class DeviceSettings extends StatefulWidget {
  const DeviceSettings({Key? key}) : super(key: key);

  @override
  DeviceSettingsState createState() => DeviceSettingsState();
}

class DeviceSettingsState extends State<DeviceSettings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var v = context.watch<NowPlayingCubit>();
    var vol = v.getVolume();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Flex(direction: Axis.vertical, children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ),
                    const Row(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceAround,
                          spacing: 16,
                          children: [
                            Column(
                              children: [
                                AnimatedVolume(),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Current device',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Circular',
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  spacing: 4,
                                  children: [
                                    Icon(
                                      Icons.volume_up_outlined,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    Text(
                                      'This phone',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 13,
                                        fontFamily: 'Circular',
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 32, 8, 8),
                      child: Row(
                        children: [
                          Text(
                            'Select a device',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Circular',
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: SizedBox(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator(
                                value: null,
                                semanticsLabel: 'Circular progress indicator',
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                                child: Icon(
                                  Icons.computer_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'My computer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Circular',
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                        child: Icon(
                          Icons.volume_down_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Slider(
                          activeColor: Colors.green,
                          inactiveColor: Colors.white.withOpacity(0.2),
                          value: vol,
                          max: 100,
                          min: 0,
                          onChanged: (double value) {
                            setState(() {
                              v.setVolume(value);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
