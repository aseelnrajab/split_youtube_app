import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerView extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerView({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.redAccent,
    );
  }
}
