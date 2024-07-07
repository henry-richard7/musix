import 'package:flutter/material.dart';
import 'package:musix/models/charts_model.dart';
import 'package:musix/pages/playlist_details_page.dart';

class ChartComponent {
  InkWell chartComponent(Charts charts, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(charts),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailsPage(
              playlistId: charts.listid.toString(),
            ),
          ),
        );
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
