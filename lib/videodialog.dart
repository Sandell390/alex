import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  int count = 10;
  Timer? timer;
  bool hasAccept = false;

  @override
  void initState() {
    super.initState();
    hasAccept = false;
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/video1.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade800,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              hasAccept == true) {
            print("hej");
            _controller.play();
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return Center(
              child: SizedBox(
                width: 700,
                height: 700,
                child: Stack(
                  children: [
                    VideoPlayer(
                      _controller,
                    ),
                    Positioned(
                      bottom: 170,
                      right: 100,
                      child: count > 0
                          ? Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Text(
                                    "Skip ad in $count seconds",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.none),
                                  )
                                ],
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                _controller.pause();
                                _controller.dispose();
                                timer?.cancel();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Text(
                                      "Skip ad!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                    Icon(
                                      Icons.skip_next,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            );
          } else {
            Future.delayed(
                Duration(seconds: 1),
                () => {
                      if (hasAccept == false)
                        {
                          showDialog(
                            context: context,
                            builder: ((context) => AlertDialog(
                                  elevation: 20,
                                  title: const Text(
                                      "Her er en lille guide på hvordan denne lille webapp virker :) \nVær sikker på at du har lyd på"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Future.delayed(Duration.zero, (() {
                                        setState((() {
                                          hasAccept = true;
                                        }));
                                        timer = Timer.periodic(
                                            Duration(seconds: 1),
                                            (Timer t) => Down());

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      })),
                                      child: const Text("Jeg har lyd på!"),
                                    ),
                                  ],
                                )),
                          )
                        }
                    });
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void Down() {
    setState(() {
      if (count > 0) count--;
    });
  }
}
