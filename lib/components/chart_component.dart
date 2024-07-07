import 'package:flutter/material.dart';
import 'package:musix/models/charts_model.dart';

class ChartComponent {
  InkWell chartComponent(Charts charts, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(charts),
      ),
      onTap: () {
        print(charts.listid);
      },
    );
  }

  BoxDecoration boxDecoration(Charts charts) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          charts.image.toString(),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}
