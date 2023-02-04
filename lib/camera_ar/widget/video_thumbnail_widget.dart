import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/preview_video_widget.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailWidget extends StatefulWidget {
  final String videoPath;
  const VideoThumbnailWidget(this.videoPath, {super.key});

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnailWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoPath)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const LoadingWidget();
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PreviewVideoWidget(
                filePath: widget.videoPath,
                fromCamera: false,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.maxFinite,
                child: VideoPlayer(_controller),
              ),
            ),
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    border: Border.all(color: Colors.white)),
                child: const Icon(
                  Icons.play_arrow_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}
