import 'package:flutter/material.dart';

import '../widget.dart';

class EffectArWidget extends StatefulWidget {
  const EffectArWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EffectArWidget> createState() => _EffectArWidgetState();
}

class _EffectArWidgetState extends State<EffectArWidget> {
  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                              r'Hiếu ứng',
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
                              r'Hiếu ứng',
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
                              r'Trang điểm',
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
                              r'Trang điểm',
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
        IndexedStack(
          index: _currIndex,
          children: const [
            SelectionFilterWidget(),
            SelectionMaskedWidget(),
          ],
        ),
      ],
    );
  }
}
