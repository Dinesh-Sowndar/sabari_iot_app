import 'package:IoT_App/pages/ch_support.dart';
import 'package:IoT_App/pages/history.dart';
import 'package:IoT_App/pages/select_user.dart';
import 'package:IoT_App/services/api_services/fireDB.dart';
import 'package:IoT_App/services/api_services/fireRD.dart';
import 'package:IoT_App/state.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChPage extends StatefulWidget {
  final String name;

  const ChPage({Key key, @required this.name}) : super(key: key);
  @override
  _ChPageState createState() => _ChPageState();
}

class _ChPageState extends State<ChPage> {
  bool loading = true;
  List<bool> devices = [];
  bool status = false;
  int support = 0;
  FirebaseDatabaseUtil fireApi = new FirebaseDatabaseUtil();
  CountState controller = Get.put(CountState());

  @override
  void initState() {
    super.initState();
    fireApi.initState();
    getData();
  }

  getData() {
    // fireApi.getCounter().once().then((val) {
    fireApi.getDevices().once().then((value) {
      // for (var i = 0; i < 5; i++) {
      setState(() {
        status = (value.value["sw0"] == 1);
      });
      // }
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: RaisedButton(
          //     color: Colors.green,
          //     onPressed: () {
          //     },
          //     child: Text(
          //       'History',
          //       style: TextStyle(color: Colors.white, fontSize: 12),
          //     ),
          //     // child: Text("Button"),
          //   ),
          // )
        ],
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await fireApi
                                .updateDevice({"sw0": !status ? 1 : 0});
                            // await fireApi.addHistory({"machine":widget.name,"line":"Line call","time_in":!status ? DateFormat('hh:mm aa')
                            //         .format(DateTime.now()) :"","time_out":status ? DateFormat('hh:mm aa')
                            //         .format(DateTime.now()) :"","date": DateFormat('dd-MM-yyyy')
                            //         .format(DateTime.now())});
                            controller.addentries({
                              "machine": widget.name,
                              "line": "Line call",
                              "time_in": !status
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "time_out": status
                                  ? DateFormat('hh:mm aa')
                                      .format(DateTime.now())
                                  : "",
                              "date": DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                            });
                            //  await Database.changeSwitchStatus("sw$index",{"sw$index" : false});

                            if (status) {
                              support++;
                            }
                            if (support == 1) {
                              support++;
                            }

                            setState(() {
                              status = !status;
                              // support = status;
                            });
                          },
                          child: Text(
                            status ? 'CALL ON' : 'CALL OFF',
                            style: TextStyle(
                                fontSize: Get.width * 0.025,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                Get.width * 0.25,
                                MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? Get.height * 0.05
                                    : Get.height * 0.2),
                            primary: status ? Colors.green : Colors.red[400],
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            // shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'LINE CALL',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.02,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        status
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cylinder Head'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.width * 0.02,
                      ),
                    ),
                    Image.asset(
                      "assets/images/device1.jpeg",
                      width: Get.width * 0.32,
                      height: Get.width * 0.32,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // await fireApi.updateDevice({"sw$index": 0});
                        // //  await Database.changeSwitchStatus("sw$index",{"sw$index" : false});
                        Get.to(History());
                      },
                      child: Text(
                        'HISTORY',
                        style: TextStyle(
                            fontSize: Get.width * 0.025,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            Get.width * 0.25,
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? Get.height * 0.08
                                : Get.height * 0.2),
                        primary: Colors.orange[800],
                        side: BorderSide(width: 1.0, color: Colors.grey),
                        // shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // await fireApi.updateDevice({"sw$index": 1});
                        // await Database.changeSwitchStatus("sw$index",{"sw$index" : true});
                        //  await fireApi.updateDevice({"sw0": 0});
                        controller.createHistory(widget.name);
                        setState(() {
                          status = false;
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
                        minimumSize: Size(
                            Get.width * 0.25,
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? Get.height * 0.08
                                : Get.height * 0.25),
                        primary: Colors.red,
                        side: BorderSide(
                          width: 1.0,
                          color: Colors.black,
                        ),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ButtonTheme(
                      minWidth: Get.width * 0.25,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? Get.height * 0.055
                          : Get.height * 0.15,
                      buttonColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: RaisedButton.icon(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: support > 1
                            ? () {
                                Get.to(ChSupport(
                                  name: widget.name,
                                ));
                              }
                            : null,
                        label: Text(
                          'SUPPORT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.width * 0.024,
                          ),
                        ),
                        // child: Text("Button"),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
