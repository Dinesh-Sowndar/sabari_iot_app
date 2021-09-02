import 'package:IoT_App/pages/select_user.dart';
import 'package:IoT_App/services/api_services/fireDB.dart';
import 'package:IoT_App/services/api_services/fireRD.dart';
import 'package:IoT_App/state.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../services/api_services/api.dart';
import '../widgets/custom_shimmer.dart';

class ChSupport extends StatefulWidget {
  final String name;

  const ChSupport({Key key, @required this.name}) : super(key: key);
  @override
  _ChSupportState createState() => _ChSupportState();
}

class _ChSupportState extends State<ChSupport> {
  bool loading = true;
  List<bool> devices = [];
  int index = 0;
  CountState controller = Get.put(CountState());
  bool maint = false;
  bool quality = false;
  bool ppc = false;
  bool tool_room = false;
  FirebaseDatabaseUtil fireApi = new FirebaseDatabaseUtil();

  @override
  void initState() {
    super.initState();
    fireApi.initState();
    getData();
  }

  getData() {
    fireApi.getDevices().once().then((value) {
      setState(() {
        maint = value.value["sw1"] == 1;
        quality = value.value["sw3"] == 1;
        ppc = value.value["sw2"] == 1;
        tool_room = value.value["sw4"] == 1;
      });
    });
    print(maint);
    print(quality);
    print(ppc);
    print(tool_room);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Container(
            width: double.infinity,
            height: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await fireApi.updateDevice({"sw1": !maint ? 1 : 0});
                            controller.addentries({
                              "machine": widget.name,
                              "line": "Maintanance",
                              "time_in": !maint
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "time_out": maint
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "date": DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                            });

                            setState(() {
                              maint = !maint;
                            });
                          },
                          child: Text(
                            maint ? 'CALL ON' : 'CALL OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.025,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                Get.width * 0.25,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Get.height * 0.05
                                    : Get.height * 0.2),

                            primary: maint ? Colors.green : Colors.red,
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            // shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' MAINTANANCE ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.025,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        maint
                            ? Text(
                                DateFormat('hh:mm aa dd-MM-yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Get.width * 0.02,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await fireApi.updateDevice({"sw2": !ppc ? 1 : 0});
                            controller.addentries({
                              "machine": widget.name,
                              "line": "PPC",
                              "time_in": !ppc
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "time_out": ppc
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "date": DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                            });
                            setState(() {
                              ppc = !ppc;
                            });
                          },
                          child: Text(
                            ppc ? 'CALL ON' : 'CALL OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.025,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                Get.width * 0.25,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Get.height * 0.05
                                    : Get.height * 0.2),

                            primary: ppc ? Colors.green : Colors.red,
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            // shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'PPC',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.025,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ppc
                            ? Text(
                                DateFormat('hh:mm aa dd-MM-yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Get.width * 0.02,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await fireApi.updateDevice({"sw$index": 1});
                    // await Database.changeSwitchStatus("sw$index",{"sw$index" : true});
                    // await fireApi.updateDevice({"sw1": 0});
                    // await fireApi.updateDevice({"sw2": 0});
                    // await fireApi.updateDevice({"sw3": 0});
                    // await fireApi.updateDevice({"sw4": 0});
                    controller.createHistory(widget.name);
                    setState(() {
                      maint = false;
                      ppc = false;
                      quality = false;
                      tool_room = false;
                    });
                    Get.offAll(
                      SelectUser(),
                    );
                  },
                  child: Text(
                    'RESET',
                    style: TextStyle(
                        fontSize: Get.width * 0.03,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                       side: BorderSide(width: 1.0, color: Colors.black,),
                    minimumSize: Size(
                        Get.width * 0.25,
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Get.height * 0.08
                            : Get.height * 0.25),
                    primary: Colors.red,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(30),
                  ),
                ),
                Column(
                  mainAxisAlignment:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await fireApi
                                .updateDevice({"sw3": !quality ? 1 : 0});
                            controller.addentries({
                              "machine": widget.name,
                              "line": "Quality",
                              "time_in": !quality
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "time_out": quality
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "date": DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                            });
                            setState(() {
                              quality = !quality;
                            });
                          },
                          child: Text(
                            quality ? 'CALL ON' : 'CALL OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.025,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                Get.width * 0.25,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Get.height * 0.05
                                    : Get.height * 0.2),

                            primary: quality ? Colors.green : Colors.red,
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            // shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'QUALITY',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.025,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        quality
                            ? Text(
                                DateFormat('hh:mm aa dd-MM-yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Get.width * 0.02,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await fireApi
                                .updateDevice({"sw4": !tool_room ? 1 : 0});
                            controller.addentries({
                              "machine": widget.name,
                              "line": "Tool Room",
                              "time_in": !tool_room
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "time_out": tool_room
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "date": DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                            });
                            setState(() {
                              tool_room = !tool_room;
                            });
                          },
                          child: Text(
                            tool_room ? 'CALL ON' : 'CALL OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.025,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                Get.width * 0.25,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Get.height * 0.05
                                    : Get.height * 0.2),

                            primary: tool_room ? Colors.green : Colors.red,
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            // shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'TOOL ROOM',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.025,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        tool_room
                            ? Text(
                                DateFormat('hh:mm aa dd-MM-yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Get.width * 0.02,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
