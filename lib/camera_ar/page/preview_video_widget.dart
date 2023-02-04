import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/store_image_page.dart';
import 'package:flutter_camera_app/utils/file_manager/file_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../widget.dart';
import 'camera_ar_page.dart';

class PreviewVideoWidget extends StatefulWidget {
  final String filePath;
  final bool fromCamera;
  const PreviewVideoWidget({
    Key? key,
    required this.filePath,
    this.fromCamera = true,
  }) : super(key: key);

  @override
  State<PreviewVideoWidget> createState() => _PreviewVideoWidgetState();
}

class _PreviewVideoWidgetState extends State<PreviewVideoWidget> {
  late VideoPlayerController _videoPlayerController;
  bool isPause = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  void _pauseVideoPlayer() async {
    await _videoPlayerController.pause();
    setState(() {
      isPause = true;
    });
  }

  void _playVideoPlayer() async {
    await _videoPlayerController.play();
    setState(() {
      isPause = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (!_videoPlayerController.value.isInitialized) {
      return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: ButtonIconWidget(
            size: 20,
            iconDefault: Icons.arrow_back_ios,
            iconPress: Icons.arrow_back_ios,
            onPress: () {
              if (widget.fromCamera) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraArPage(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StoreImagePage(),
                  ),
                );
              }
            },
          ),
          title: const Text(
            r'Preview Video',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: const LoadingWidget(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: ButtonIconWidget(
            size: 20,
            iconDefault: Icons.arrow_back_ios,
            iconPress: Icons.arrow_back_ios,
            onPress: () {
              if (widget.fromCamera) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraArPage(),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StoreImagePage(),
                  ),
                );
              }
            },
          ),
          title: const Text(
            r'Preview Video',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      GestureDetector(
                          onTap: _pauseVideoPlayer,
                          child: VideoPlayer(_videoPlayerController)),
                      if (isPause) ...[
                        InkWell(
                          borderRadius: BorderRadius.circular(180),
                          onTap: _playVideoPlayer,
                          child: SizedBox(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: Center(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(180),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_outlined,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 24,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  FileManager().deleteFile(widget.filePath);
                  if (widget.fromCamera) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraArPage(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StoreImagePage(),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 140,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.shade200,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: Colors.red.shade200,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          r'Xóa video',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red.shade200,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (widget.fromCamera) ...[
              Positioned(
                bottom: 12,
                right: 24,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    FileManager()
                        .createFileInDirectory(widget.filePath, 'mp4')
                        .then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoreImagePage(),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade200,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            size: 24,
                            color: Colors.green.shade200,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            r'Lưu video',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green.shade200,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ] else ...[
              Positioned(
                bottom: 12,
                right: 24,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    final box = context.findRenderObject() as RenderBox?;

                    await Share.shareXFiles(
                      [XFile(widget.filePath)],
                      sharePositionOrigin:
                          box!.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                  child: Container(
                    width: 140,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade200,
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            size: 24,
                            color: Colors.blue.shade200,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            r'Chia sẻ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue.shade200,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ],
        ),
      );
    }
  }
}
