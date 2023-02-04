import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/file_manager/file_manager.dart';
import '../widget.dart';
import 'camera_ar_page.dart';
import 'store_image_page.dart';

class PreviewImageWidget extends StatelessWidget {
  final String filePath;
  final bool fromCamera;
  const PreviewImageWidget({
    Key? key,
    required this.filePath,
    this.fromCamera = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: ButtonIconWidget(
          size: 20,
          iconDefault: Icons.arrow_back_ios,
          iconPress: Icons.arrow_back_ios,
          onPress: () {
            if (fromCamera) {
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
          r'Preview Hình ảnh',
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
                child: Image.file(
                  File(filePath),
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.cover,
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
                FileManager().deleteFile(filePath);
                if (fromCamera) {
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
                        r'Xóa ảnh',
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
          if (fromCamera) ...[
            Positioned(
              bottom: 12,
              right: 24,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  FileManager()
                      .createFileInDirectory(filePath, 'jpg')
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
                          r'Lưu ảnh',
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
                    [XFile(filePath)],
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
