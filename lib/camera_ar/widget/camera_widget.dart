import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatelessWidget {
  const CameraWidget({
    super.key,
    required this.size,
    required DeepArController? controller,
  }) : _controller = controller;

  final Size size;
  final DeepArController? _controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.72,
          child: DeepArPreview(_controller!),
        ),
      ),
      // child: SingleChildScrollView(
      //     scrollDirection: Axis.vertical,
      //     child: Center(
      //       child: SingleChildScrollView(
      //         scrollDirection: Axis.horizontal,
      //         child: Column(
      //           children: [
      //             SizedBox(
      //               width: size.width,
      //               height: size.height,
      //               child: AspectRatio(
      //                   aspectRatio: 1 / _controller!.aspectRatio,
      //                   child: DeepArPreview(_controller!)),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )),
      // ),
    );
  }
}
