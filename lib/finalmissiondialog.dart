import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FinalMissionScreem extends StatefulWidget {
  const FinalMissionScreem({super.key});

  @override
  State<FinalMissionScreem> createState() => _FinalMissionScreemState();
}

class _FinalMissionScreemState extends State<FinalMissionScreem> {
  @override
  final player = AudioPlayer();
  Timer? timer;

  int count = 0;
  double transparentCount = 0;

  late BuildContext _buildContext;

  int x = 0;
  int y = 0;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(milliseconds: 500), (Timer t) => MoveButton());
    initPlayer();
  }

  Widget build(BuildContext context) {
    _buildContext = context;
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: transparentCount,
              child: Image(
                image: AssetImage("assets/troll.png"),
              ),
            ),
          ),
          Positioned(
            left: x.toDouble(),
            top: y.toDouble(),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green),
                child: TextButton(
                    onPressed: () {
                      if (count < 20) return;
                      timer?.cancel();
                      stopPlayer();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Get me out of here!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))),
          ),
        ],
      ),
    );
  }

  void MoveButton() {
    if (_buildContext == null) {
      return;
    }
    setState(() {
      if (count < 78) {
        x = Random().nextInt(
                MediaQuery.of(_buildContext).size.width.toInt() - 600) +
            300;
        y = Random().nextInt(
                MediaQuery.of(_buildContext).size.height.toInt() - 600) +
            300;
      }
      if (transparentCount <= 0.99) {
        transparentCount += 0.002;
      }
      count++;
    });
  }

  void initPlayer() async {
    await player.play(AssetSource("song2.mp3"));
  }

  void stopPlayer() async {
    await player.stop();
  }
}
