import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:another/widgets/target_box.dart';
import '../../../constant/color.dart';

class MyRecordResult extends StatelessWidget {
  final List<String> walkCounts;
  final List<String> kcals;
  final List<String> runningTimes;
  final List<String> runningDistances;

  const MyRecordResult({
    required this.walkCounts,
    required this.kcals,
    required this.runningTimes,
    required this.runningDistances,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now().toLocal();
    now = now.add(Duration(seconds: 35 * 3600 + 60 * 28 + 26));
    String formattedDate = DateFormat('yyyy.MM.dd').format(now);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 16.0,
      ),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: BLACK_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(color: MAIN_COLOR, fontSize: 20.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TargetBox(
                              data: runningDistances[0],
                              name: 'km',
                              textColor: WHITE_COLOR,
                              recordColor: SERVEONE_COLOR,
                            ),
                            TargetBox(
                              data: kcals[0],
                              name: 'kcal',
                              textColor: WHITE_COLOR,
                              recordColor: SERVEONE_COLOR,
                            ),
                            TargetBox(
                              data: runningTimes[0],
                              name: '시간',
                              textColor: WHITE_COLOR,
                              recordColor: SERVEONE_COLOR,
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       walkCounts[0],
                      //       style: TextStyle(color: MAIN_COLOR, fontSize: 40.0),
                      //     ),
                      //     Text('걸음',
                      //         style:
                      //             TextStyle(color: MAIN_COLOR, fontSize: 20.0))
                      //   ],
                      // ),
                    ],
                  ),
                  ImageProfileSetting()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget ImageProfileSetting() {
  return Center(
    child: Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('assets/img/kazuha.jpg'),
          radius: 45,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: MAIN_COLOR,
              radius: 15,
              child: Icon(
                Icons.edit,
                color: WHITE_COLOR,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
