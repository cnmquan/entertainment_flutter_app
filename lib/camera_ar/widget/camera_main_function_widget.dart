import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/preview_image_widget.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';

import '../../utils/constants/global_constants.dart';
import '../page/preview_video_widget.dart';
import '../page/store_image_page.dart';

class CameraMainFunctionWidget extends StatefulWidget {
  final DeepArController? controller;
  const CameraMainFunctionWidget({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  State<CameraMainFunctionWidget> createState() =>
      _CameraMainFunctionWidgetState();
}

class _CameraMainFunctionWidgetState extends State<CameraMainFunctionWidget> {
  bool _isPhoto = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _isPhoto
                  ? null
                  : () {
                      setState(() {
                        _isPhoto = !_isPhoto;
                      });
                      if (widget.controller!.isRecording) {
                        widget.controller!.stopVideoRecording().then((file) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return PreviewVideoWidget(
                              filePath: file.path,
                              fromCamera: true,
                            );
                          }));
                        });
                      }
                    },
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 32,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isPhoto) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                      Text(
                        r'Photo',
                        style: _isPhoto
                            ? const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14)
                            : const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white54,
                                fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: !_isPhoto
                  ? null
                  : () {
                      setState(() {
                        _isPhoto = !_isPhoto;
                      });
                    },
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 80,
                height: 32,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isPhoto) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                      ],
                      Text(
                        r'Video',
                        style: !_isPhoto
                            ? const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14)
                            : const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white54,
                                fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _showBottomSheetWidget(context);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      GlobalImageManager.filterAsset,
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    r'Hiệu ứng',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (_isPhoto) {
                  widget.controller!.takeScreenshot().then((file) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return PreviewImageWidget(
                        filePath: file.path,
                        fromCamera: true,
                      );
                    }));
                  });
                } else {
                  if (widget.controller!.isRecording) {
                    widget.controller!.stopVideoRecording().then(
                      (file) {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return PreviewVideoWidget(
                            filePath: file.path,
                            fromCamera: true,
                          );
                        }));
                      },
                    );
                  } else {
                    await widget.controller!.startVideoRecording();
                  }
                }
                setState(() {});
              },
              borderRadius: BorderRadius.circular(180),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(180),
                child: Container(
                  width: 60,
                  height: 60,
                  color: widget.controller!.isRecording
                      ? Colors.red.shade300
                      : Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const StoreImagePage()),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      GlobalImageManager.folderAsset,
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    r'Kho ảnh',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showBottomSheetWidget(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black54,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: EffectArWidget(),
          ),
        );
      },
    );
  }
}
