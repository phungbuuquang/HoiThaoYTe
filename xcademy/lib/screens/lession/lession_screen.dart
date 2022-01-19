import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessionScreen extends StatefulWidget {
  const LessionScreen({Key? key}) : super(key: key);

  @override
  _LessionScreenState createState() => _LessionScreenState();
}

class _LessionScreenState extends State<LessionScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.rmp-streaming.com/media/big-buck-bunny-360p.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài học'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(children: [
                    VideoPlayer(_controller),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                              // _timer.cancel();
                            } else {
                              _controller.play();
                              // startTimer();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.blue.withOpacity(0.8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                )
              : Container(),
        ],
      ),
    );
  }
}
