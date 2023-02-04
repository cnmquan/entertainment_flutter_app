import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/logic/ar_logic.dart';
import 'package:flutter_camera_app/camera_ar/utils.dart';
import 'package:flutter_camera_app/camera_ar/widget/selection_card_widget.dart';
import 'package:provider/provider.dart';

class SelectionMaskedWidget extends StatelessWidget {
  const SelectionMaskedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeepArLogic>(builder: (context, provider, child) {
      return SizedBox(
          width: double.infinity,
          height: 150,
          child: ListView.builder(
              itemCount: arMaskedList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectionCardWidget(
                    assetName: arMaskedList[index].assetName,
                    name: arMaskedList[index].name,
                    selected: provider.masked?.name == arMaskedList[index].name,
                    onPress: () {
                      if (provider.masked?.name == arMaskedList[index].name) {
                        provider.removeArMasked();
                      } else {
                        provider.chooseArMasked(arMaskedList[index]);
                      }
                    },
                  ),
                );
              }));
    });
  }
}
