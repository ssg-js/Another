import 'package:another/constant/color.dart';
import 'package:another/constant/text_style.dart';
import 'package:another/screens/feed/detail_feed.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  List<String> thumbnailUrls = [];
  List<String> runningIds = [];
  List<String> runningTimes = [];
  List<String> runningDistances = [];
  // List<String> walkCounts = [];

  ImageBox({
    required this.thumbnailUrls,
    required this.runningIds,
    required this.runningTimes,
    required this.runningDistances,
    // required this.walkCounts,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: widget.thumbnailUrls.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: _buildListItem(context, index),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailFeed(
                    runningId: widget.runningIds[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Stack(
      children: [
        Image.network(
          widget.thumbnailUrls[index],
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        Positioned(
          bottom: 8.0,
          width: 110.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.runningDistances[index],
                style: MyTextStyle.fourteenTextStyle.copyWith(
                  color: MAIN_COLOR,
                ),
              ),
              // SizedBox(
              //   width: 10.0,
              // ),
              // Text(
              //   widget.walkCounts[index],
              //   style: MyTextStyle.fourteenTextStyle.copyWith(
              //     color: RED_COLOR,
              //   ),
              // ),
              // SizedBox(
              //   width: 10.0,
              // ),
              Text(
                widget.runningTimes[index],
                style: MyTextStyle.fourteenTextStyle.copyWith(
                  color: MAIN_COLOR,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
