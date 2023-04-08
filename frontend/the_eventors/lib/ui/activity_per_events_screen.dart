import 'dart:async';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/EventProvider.dart';

import '../models/dto/ActivityOfEventDto.dart';

class ActivityPerEventScreen extends StatefulWidget {
  final int id;
  const ActivityPerEventScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ActivityPerEventScreen> createState() => _ActivityPerEventScreenState();
}

class _ActivityPerEventScreenState extends State<ActivityPerEventScreen> {
  ActivityOfEventDto activity = ActivityOfEventDto();
  late Timer _timer;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<EventProvider>(context, listen: false).getActivity(widget.id);
    Future.delayed(const Duration(milliseconds: 150), () async {
      activity = context.read<EventProvider>().activity;
      setState(() {
        isLoading = false;
      });
    });

    /* _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      context.read<EventProvider>().getActivity(widget.id);
      activity = context.read<EventProvider>().activity;
    });*/
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Text("")
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return ScreenUtilInit(
                  designSize: const Size(360, 690),
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (context, child) {
                    return SafeArea(
                        child: Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: true,
                              title: Text(
                                "Activity",
                                style: TextStyle(
                                    color: Color(0xFFEEFBFB),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: const Color(0xFF203647),
                            ),
                            backgroundColor: const Color(0xFF203647),
                            body: SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Consumer<EventProvider>(
                                    builder: (context, data, child) {
                                  print(data.activity.users);
                                  return Container(
                                      color: const Color(0xFF203647),
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            DataTable(columns: const [
                                              DataColumn(
                                                label: Text('Activity',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB))),
                                              ),
                                              DataColumn(
                                                label: Text('Numbers',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB))),
                                              ),
                                            ], rows: [
                                              DataRow(cells: [
                                                const DataCell(Text('Going',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                                DataCell(Text(
                                                    data.activity.going
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text(
                                                    'Interested',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                                DataCell(Text(
                                                    data.activity.interested
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                              ]),
                                            ]),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: DChartPie(
                                                  data: [
                                                    {
                                                      'domain': 'Going',
                                                      'measure':
                                                          data.activity.going
                                                    },
                                                    {
                                                      'domain': 'Interested',
                                                      'measure': data
                                                          .activity.interested
                                                    },
                                                  ],
                                                  fillColor: (pieData, index) {
                                                    switch (pieData['domain']) {
                                                      case 'Going':
                                                        return Colors.blue;
                                                      case 'Interested':
                                                        return Colors
                                                            .blueAccent;

                                                      default:
                                                        return Colors.orange;
                                                    }
                                                  },
                                                  pieLabel: (pieData, index) {
                                                    return "${pieData['domain']}:\n${pieData['measure']}%";
                                                  },
                                                  labelColor:
                                                      const Color(0xFFEEFBFB),
                                                  labelFontSize: 12.sp.toInt(),
                                                  labelPosition:
                                                      PieLabelPosition.auto,
                                                ),
                                              ),
                                            ),
                                            DataTable(columns: [
                                              DataColumn(
                                                label: Text('Type of vistiors',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                        fontSize: 8.sp)),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                    'Views of your event',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFEEFBFB),
                                                        fontSize: 8.sp)),
                                              ),
                                            ], rows: [
                                              DataRow(cells: [
                                                const DataCell(Text(
                                                    'Your followers',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                                DataCell(Text(
                                                    data.activity.followers
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Users',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                                DataCell(Text(
                                                    data.activity.users
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                              ]),
                                              DataRow(cells: [
                                                const DataCell(Text('Anonymous',
                                                    style: TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                                DataCell(Text(
                                                    data.activity.anonymous
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFFEEFBFB)))),
                                              ]),
                                            ]),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: DChartPie(
                                                  data: [
                                                    {
                                                      'domain': 'Followers',
                                                      'measure': data
                                                          .activity.followers
                                                    },
                                                    {
                                                      'domain': 'Anonymous',
                                                      'measure': data
                                                          .activity.anonymous
                                                    },
                                                    {
                                                      'domain': 'Users',
                                                      'measure':
                                                          data.activity.users
                                                    },
                                                  ],
                                                  fillColor: (pieData, index) {
                                                    switch (pieData['domain']) {
                                                      case 'Followers':
                                                        return Colors.blue;
                                                      case 'Users':
                                                        return Colors
                                                            .blueAccent;

                                                      default:
                                                        return Colors
                                                            .blue.shade700;
                                                    }
                                                  },
                                                  pieLabel: (pieData, index) {
                                                    return "${pieData['domain']}:\n${pieData['measure']}%";
                                                  },
                                                  labelColor:
                                                      const Color(0xFFEEFBFB),
                                                  labelFontSize: 6.sp.toInt(),
                                                  labelPosition:
                                                      PieLabelPosition.auto,
                                                ),
                                              ),
                                            ),
                                          ]));
                                }),
                              ),
                            )));
                  });
            });
  }
}
