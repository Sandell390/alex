import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SocialCreditScreen extends StatefulWidget {
  const SocialCreditScreen({super.key});

  @override
  State<SocialCreditScreen> createState() => _SocialCreditScreenState();
}

class _SocialCreditScreenState extends State<SocialCreditScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final player = AudioPlayer();
  Timer? timer;
  late double socialCredits;
  bool hasAccept = false;

  @override
  void initState() {
    super.initState();
    socialCredits = 0.1;
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/video2.mp4',
    );
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => IncrementCredits());
    _initializeVideoPlayerFuture = _controller.initialize();
    initPlayer();
    _controller.setLooping(true);
    _controller.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      child: Column(
        children: [
          Text(
            "Social credits: ${socialCredits.toStringAsFixed(2)}",
            style:
                TextStyle(decoration: TextDecoration.none, color: Colors.white),
          ),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("hej");
                _controller.play();
                return Column(
                  children: [
                    Container(
                      width: 500,
                      height: 500,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue.shade100),
                      width: 300,
                      height: 50,
                      child: socialCredits > 100
                          ? TextButton(
                              onPressed: () {
                                stopPlayer();
                                _controller.pause();
                                _controller.dispose();
                                timer?.cancel();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Finish mission",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    color: Colors.black),
                              ))
                          : Center(
                              child: Text(
                                "At least 100 Social credits is needed",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                            ),
                    )
                  ],
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void initPlayer() async {
    player.setReleaseMode(ReleaseMode.loop);
    await player.play(AssetSource("song1.mp3"));
  }

  void stopPlayer() async {
    await player.stop();
  }

  void IncrementCredits() {
    setState(() {
      socialCredits = socialCredits * 1.05;
    });
  }
}
