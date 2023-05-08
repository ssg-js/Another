import 'package:another/constant/main_layout.dart';
import 'package:another/screens/feed/all_feed_screen.dart';
import 'package:another/screens/feed/api/feed_api.dart';
import 'package:another/screens/feed/api/my_feed_api.dart';
import 'package:another/screens/feed/my_feed_screen.dart';
import 'package:another/screens/feed/widgets/feed_select.dart';
import 'package:another/screens/feed/widgets/my_feed_result.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/color.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool isFeed = true;
  List<String> thumbnailUrls = [];
  List<String> runningIds = [];
  List<String> runningTimes = [];
  List<String> runningDistances = [];
  List<String> walkCounts = [];
  List<String> kcals = [];

  @override
  void initState() {
    super.initState();
    _loadFeed();
  }

  Future<void> _loadFeed() async {
    try {
      final response = await FeedApi.getFeed();
      final contents = response['data']['content'];
      List<String> feedPicUrls = [];
      List<String> runningIdsList = [];
      List<String> runningTimeList = [];
      List<String> runningDistanceList = [];
      List<String> walkCountList = [];

      for (var content in contents) {
        List<Map<String, dynamic>> feedPics =
            List<Map<String, dynamic>>.from(content['feedPic']);

        if (feedPics.isNotEmpty) {
          feedPicUrls.add(feedPics[0]['feedPic']);
          runningIdsList.add(content['runningId'].toString());
          runningTimeList.add(content['runningTime'].toString());
          runningDistanceList.add(content['runningDistance'].toString());
          walkCountList.add(content['walkCount'].toString());
        }
      }

      setState(
        () {
          thumbnailUrls = feedPicUrls;
          runningIds = runningIdsList;
          runningTimes = runningTimeList;
          runningDistances = runningDistanceList;
          walkCounts = walkCountList;
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> _myFeed() async {
    try {
      final response = await MyFeedApi.getFeed('1');
      final contents = response['data']['content'];
      List<String> feedPicUrls = [];
      List<String> runningIdsList = [];
      List<String> runningTimeList = [];
      List<String> runningDistanceList = [];
      List<String> walkCountList = [];
      List<String> kcalList= [];
      if (contents == []) {
        for (var content in contents) {
          List<Map<String, dynamic>> feedPics =
          List<Map<String, dynamic>>.from(content['feedPic']);

          if (feedPics.isNotEmpty) {
            feedPicUrls.add(feedPics[0]['feedPic']);
            runningIdsList.add(content['runningId'].toString());
            runningTimeList.add(content['runningTime'].toString());
            runningDistanceList.add(content['runningDistance'].toString());
            walkCountList.add(content['walkCount'].toString());
            kcalList.add(content['kcal'].toString());
          }
        }
      } else {
        runningIdsList.add('0');
        runningTimeList.add('0');
        runningDistanceList.add('0');
        walkCountList.add('0');
        kcalList.add('0');
      }
      setState(
        () {
          thumbnailUrls = feedPicUrls;
          runningIds = runningIdsList;
          runningTimes = runningTimeList;
          runningDistances = runningDistanceList;
          walkCounts = walkCountList;
          kcals =kcalList;
        },
      );
      // print(kcals);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('로고'),
              expandedHeight: 25.0,
              backgroundColor: BACKGROUND_COLOR,
            ),
            SliverToBoxAdapter(
              child: isFeed ? Container() : MyRecordResult(
                  walkCounts: walkCounts,
                  kcals: kcals,
                  runningTimes : runningTimes,
                  runningDistances : runningDistances,
              ),
            ),
          ];
        },
        body: Column(
          children: [
            FeedSelect(
              onChanged: (value) {
                setState(
                  () {
                    isFeed = value;
                    if (isFeed) {
                      _loadFeed();
                    } else {
                      _myFeed();
                    }
                  },
                );
              },
            ),
            Expanded(
              child: isFeed
                  ? AllFeedScreen(
                      thumbnailUrls: thumbnailUrls,
                      runningIds: runningIds,
                      runningTimes: runningTimes,
                      runningDistances: runningDistances,
                      walkCounts: walkCounts,
                    )
                  : MyFeedScreen(
                      thumbnailUrls: thumbnailUrls,
                      runningIds: runningIds,
                      runningTimes: runningTimes,
                      runningDistances: runningDistances,
                      walkCounts: walkCounts,
                      kcals: kcals
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
