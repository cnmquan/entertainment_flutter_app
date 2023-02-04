import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/preview_image_widget.dart';

class ImageThumbnailWidget extends StatelessWidget {
  final String imagePath;
  const ImageThumbnailWidget({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PreviewImageWidget(
              filePath: imagePath,
              fromCamera: false,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
      ),
    );
  }
}
