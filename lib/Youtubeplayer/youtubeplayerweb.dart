import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerWeb extends StatefulWidget {
  final String url;

  const YoutubePlayerWeb({Key? key, required this.url}) : super(key: key);
  

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayerWeb> {
  late YoutubePlayerController _controller;

  void runYoutubePlay()
  {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayerController.convertUrlToId(widget.url).toString(),
      params: const YoutubePlayerParams(
        showControls: true,
        desktopMode: true,
        showFullscreenButton: true,
        privacyEnhanced: true,
        showVideoAnnotations: true ,
        autoPlay: false,
        enableCaption: true,
        color: 'red',
      )
    );
  }

  void youtubePlayerFullScreen()
  {
    _controller.onEnterFullscreen = ()
    {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      print("ENTERED FULLSCREEN");
    };
    _controller.onExitFullscreen = ()
    {
      print("EXITED FULLSCREEN");
    };
  }
  
  @override
  void initState() {
      runYoutubePlay();
      youtubePlayerFullScreen();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(controller: _controller, child: player);
  }

}