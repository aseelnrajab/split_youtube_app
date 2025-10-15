import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:split_youtube_app/l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/youtube_player_view.dart';
import '../widgets/camera_view.dart';
import '../utils/permission_utils.dart';

import '../main.dart';

class SplitScreenPage extends StatefulWidget {
  const SplitScreenPage({super.key});

  @override
  State<SplitScreenPage> createState() => _SplitScreenPageState();
}

class _SplitScreenPageState extends State<SplitScreenPage> {
  late final YoutubePlayerController _youtubeController;
  CameraController? _cameraController;

  bool _isCameraInitialized = false;
  bool _isCameraVisible = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initYouTubePlayer();
  }

  void _initYouTubePlayer() {
    const videoUrl = 'https://www.youtube.com/watch?v=hTqtGJwsJVE';
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        enableCaption: true,
      ),
    );
  }

  Future<void> _initializeCamera() async {
    final hasPermission = await ensureCameraPermission(context);
    if (!hasPermission) return;

    if (cameras == null || cameras!.isEmpty) {
      _showSnack(AppLocalizations.of(context)!.noCameraDetected);
      return;
    }

    final controller = CameraController(
      cameras![_selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller.initialize();

      if (!mounted) return;
      setState(() {
        _cameraController = controller;
        _isCameraInitialized = true;
        _isCameraVisible = true;
      });
    } catch (e) {
      _showSnack(
        '${AppLocalizations.of(context)!.cameraInitError.toString()} $e',
      );
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.length < 2) {
      _showSnack(AppLocalizations.of(context)!.noSecondaryCamera.toString());
      return;
    }

    _selectedCameraIndex = _selectedCameraIndex == 0 ? 1 : 0;
    await _cameraController?.dispose();
    await _initializeCamera();
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppLocalizations.of(context)!.appTitle)),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: CameraView(
              isVisible: _isCameraVisible,
              isInitialized: _isCameraInitialized,
              cameraController: _cameraController,
              onSwitchCamera: _switchCamera,
              onInitializeCamera: _initializeCamera,
              onHideCamera: () async {
                await _cameraController?.dispose();
                setState(() {
                  _isCameraVisible = false;
                  _isCameraInitialized = false;
                });
              },
            ),
          ),

          Expanded(
            flex: 1,
            child: YoutubePlayerView(controller: _youtubeController),
          ),
        ],
      ),
    );
  }
}
