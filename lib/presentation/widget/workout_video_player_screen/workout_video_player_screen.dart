
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WorkoutVideoPlayerScreen extends StatefulWidget {
  const WorkoutVideoPlayerScreen({
    super.key,
    this.id,
    required this.videoUrl,
  });

  final String? id;
  final String videoUrl;

  @override
  State<WorkoutVideoPlayerScreen> createState() =>
      _WorkoutVideoPlayerScreenState();
}

class _WorkoutVideoPlayerScreenState extends State<WorkoutVideoPlayerScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      final VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await controller.initialize();
      final ChewieController chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: false,
      );
      if (!mounted) {
        await controller.dispose();
        chewieController.dispose();
        return;
      }
      setState(() {
        _videoPlayerController = controller;
        _chewieController = chewieController;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Video could not be loaded.';
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Workout Video'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : _errorMessage != null
                ? Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  )
                : Chewie(controller: _chewieController!),
      ),
    );
  }
}
