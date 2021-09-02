import 'dart:async';

import 'package:IoT_App/services/api_services/fireDB.dart';
import 'package:IoT_App/services/api_services/fireRD.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../services/api_services/api.dart';
import '../widgets/custom_shimmer.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  List<bool> devices = [];
  FirebaseDatabaseUtil fireApi = new FirebaseDatabaseUtil();
  StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;

  @override
  void initState() {
    super.initState();
    fireApi.initState();
    getData();
     _homeButtonSubscription = HardwareButtons.homeButtonEvents.listen((event) {
     print("press home");
    });
  }

  getData() {
    fireApi.getCounter().once().then((val) {
      fireApi.getDevices().once().then((value) {
        for (var i = 0; i < val.value; i++) {
          setState(() {
            devices.add(value.value["sw$i"] == 1);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IoT App'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ListView.separated(
          padding: EdgeInsets.only(top: 15),
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 0.8,
            );
          },
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text(
                  'Switch $index',
                  style: TextStyle(color: Colors.brown, fontSize: 16),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await fireApi.updateDevice({"sw$index": 0});
                        //  await Database.changeSwitchStatus("sw$index",{"sw$index" : false});
                        setState(() {
                          devices[index] = false;
                        });
                      },
                      child: Text(
                        'OFF',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: devices[index] ? Colors.grey : Colors.red[300],
                        side: BorderSide(width: 1.0, color: Colors.grey),
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(35),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await fireApi.updateDevice({"sw$index": 1});
                        // await Database.changeSwitchStatus("sw$index",{"sw$index" : true});
                        setState(() {
                          devices[index] = true;
                        });
                      },
                      child: Text('ON'),
                      style: ElevatedButton.styleFrom(
                        primary: devices[index] ? Colors.green : Colors.grey,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(35),
                      ),
                    )
                  ],
                ),
                devices[index]
                    ? Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Switch Turn ON @ ' +
                                DateFormat('hh:mm aa dd-MM-yyyy')
                                    .format(DateTime.now()),
                            style: TextStyle(color: Colors.black, fontSize: 11),
                          ),
                        ],
                      )
                    : SizedBox(),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
