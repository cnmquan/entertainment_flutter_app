import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/camera_ar_page.dart';
import 'package:flutter_camera_app/utils/file_manager/file_manager.dart';

import '../widget.dart';

class StoreImagePage extends StatefulWidget {
  const StoreImagePage({Key? key}) : super(key: key);

  @override
  State<StoreImagePage> createState() => _StoreImagePageState();
}

class _StoreImagePageState extends State<StoreImagePage> {
  List<File> photos = [];
  List<File> videos = [];
  bool isLoading = true;
  int _currIndex = 0;

  @override
  void initState() {
    super.initState();
    getImageVideoList();
  }

  void getImageVideoList() async {
    List<File> files = await FileManager().getListFileInDictionary();
    for (var file in files) {
      if (file.path.contains('jpg')) {
        photos.add(file);
      } else if (file.path.contains('mp4')) {
        videos.add(file);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: ButtonIconWidget(
            size: 20,
            iconDefault: Icons.arrow_back_ios,
            iconPress: Icons.arrow_back_ios,
            onPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CameraArPage(),
                ),
              );
            },
          ),
          title: const Text(
            r'Kho lưu trữ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        body: const Center(
          child: LoadingWidget(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: ButtonIconWidget(
          size: 20,
          iconDefault: Icons.arrow_back_ios,
          iconPress: Icons.arrow_back_ios,
          onPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CameraArPage(),
              ),
            );
          },
        ),
        title: const Text(
          r'Kho lưu trữ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        _currIndex = 0;
                      });
                    },
                    child: Row(
                      children: [
                        if (_currIndex == 0) ...[
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white30,
                            ),
                            child: const Center(
                              child: Text(
                                r'Hình ảnh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ] else ...[
                          const SizedBox(
                            width: 100,
                            height: 32,
                            child: Center(
                              child: Text(
                                r'Hình ảnh',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() {
                        _currIndex = 1;
                      });
                    },
                    child: Row(
                      children: [
                        if (_currIndex == 1) ...[
                          Container(
                            width: 100,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white30,
                            ),
                            child: const Center(
                              child: Text(
                                r'Video',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ] else ...[
                          const SizedBox(
                            width: 100,
                            height: 32,
                            child: Center(
                              child: Text(
                                r'Video',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white70,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currIndex,
              children: [
                if (photos.isEmpty) ...[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline_outlined,
                          color: Colors.red.shade200,
                          size: 60,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          r'Hiện tại chưa có hình ảnh',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade200,
                              fontSize: 28),
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          return ImageThumbnailWidget(
                              imagePath: photos[index].path);
                        }),
                  ),
                ],
                if (videos.isEmpty) ...[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline_outlined,
                          color: Colors.red.shade200,
                          size: 60,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          r'Hiện tại chưa có video',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.red.shade200,
                              fontSize: 28),
                        ),
                      ],
                    ),
                  )
                ] else ...[
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return VideoThumbnailWidget(videos[index].path);
                        }),
                  ),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
