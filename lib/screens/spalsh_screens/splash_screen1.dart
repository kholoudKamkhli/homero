import 'package:flutter/material.dart';
import 'package:homero/screens/home_screen/home_screen_view.dart';
import 'package:video_player/video_player.dart';

class SplashScreenOne extends StatefulWidget {
static const String routeName = "splash1";
  @override
  State<SplashScreenOne> createState() => _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  final VideoPlayerController _controller =
  VideoPlayerController.asset('assets/images/SplashScreenHomearo.mp4');
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      _controller.play();
      Future.delayed(Duration(seconds: 6)).then((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenView(),
          ),
        );
      });
    });
  }
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Container(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
