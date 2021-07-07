import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerAndroid extends StatefulWidget {
  final String url;
  const YoutubePlayerAndroid({Key? key, required this.url}) : super(key: key);

  @override
  _YoutubePlayerAndroidState createState() => _YoutubePlayerAndroidState();
}

class _YoutubePlayerAndroidState extends State<YoutubePlayerAndroid> {
  late YoutubePlayerController _controller;

  void runYoutubePlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url).toString(),
        flags: YoutubePlayerFlags(
          enableCaption: true,
          isLive: false,
          autoPlay: false,
        )
        );
  }

  
  @override
  void initState() {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          controller: _controller,
          aspectRatio: 16/9,
        ),
        builder: (context,player)
        {
          return SizedBox(
            child: player,
          );
        },
        );
  }
}
