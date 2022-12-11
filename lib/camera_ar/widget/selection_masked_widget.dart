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
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.lightBlueAccent.withOpacity(0.4),
          child: SizedBox(
              width: double.infinity,
              height: 150,
              child: ListView.builder(
                  itemCount: arFilterList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SelectionCardWidget(
                      assetName: arFilterList[index].assetName,
                      name: arFilterList[index].name,
                      selected: provider.masked?.id == index,
                      onPress: () {
                        if (provider.masked?.id == index) {
                          provider.removeArMasked();
                        } else {
                          provider.chooseArMasked(arFilterList[index]);
                        }
                      },
                    );
                  })),
        ),
      );
    });
  }
}
