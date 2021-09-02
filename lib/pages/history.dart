import 'dart:io';

import 'package:IoT_App/services/api_services/fireRD.dart';
import 'package:animate_do/animate_do.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share/share.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool loading = true;
  FirebaseDatabaseUtil fireApi = new FirebaseDatabaseUtil();
  var history = [];

  @override
  void initState() {
    super.initState();
    fireApi.initState();

    getData();
  }

  getData() {
    fireApi.getHistory().once().then((value) {
      if (value.value != null) value.value.forEach((k, v) => history.add(v));

      setState(() {
        loading = false;
      });
      print(history);
    });
  }

  generateCsv() async {
    List<List<String>> data = [
      ["SL.NO", "MACHINE NUMBER", "CALL", "DATE", "TIME IN", "TIME OUT"],
    ];

    for (var i = 0; i < history.length; i++) {

    for (var k = 0; k < history[i].length; k++) {
      data.add([
        k.toString(),
        history[i][k]["machine"],
        history[i][k]["line"],
        history[i][k]["date"],
        history[i][k]["time_in"],
        history[i][k]["time_out"],
      ]);
    }
     data.add(
        [i.toString(), " ", "", "", "", " "],
      );
    }

    String csvData = ListToCsvConverter().convert(data);
    final String directory = (await getApplicationSupportDirectory()).path;
    final path = "$directory/csv-${DateTime.now().toIso8601String()}.csv";
    print(path);
    final File file = File(path);
    await file.writeAsString(csvData);
    Share.shareFiles([path]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History".toUpperCase()),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  generateCsv();
                },
                child: Text("TRENDS" ,style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.amber[600],
                shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  generateCsv();
                },
                child: Text("Export".toUpperCase(),style: TextStyle(color: Colors.white))
              ),
            )
          ],
        ),
        body:

            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
            : history.length.isEqual(0)
                ? Center(
                    child: Text(
                      "No Data Found!",
                      style: TextStyle(
                          fontSize: Get.width * 0.021, color: Colors.grey),
                    ),
                  )
                :

            //  ListView.builder(
            //     shrinkWrap: true,
            //     physics: ScrollPhysics(),
            //     itemCount: history.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(12.0),
            //         child: Container(
            //           width: Get.width / 1.1,
            //           padding: EdgeInsets.only(left: 5),
            //           decoration: BoxDecoration(
            //             // color: convertedData[index].entryStatus
            //             //     ? Color(0xFF232426)
            //             //     : Color(0xFF48494B),
            //             color: Colors.grey[100],
            //             border: Border.all(color: Colors.grey),
            //             borderRadius:
            //                 BorderRadius.all(Radius.circular(10.0)),
            //           ),
            //           child: Column(
            //             children: [
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(6.0),
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     infoWidget("Sno", "$index"),
            //                     infoWidget("Machine No",
            //                         history[index]["machine"]),
            //                     infoWidget("Line", history[index]["line"]),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 6,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(6.0),
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     infoWidget("Date", history[index]["date"]),
            //                     infoWidget(
            //                         "Time In", history[index]["time_in"]),
            //                     infoWidget(
            //                         "Time out", history[index]["time_out"]),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     }));

            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: Get.width / 1.1,
                      padding: EdgeInsets.only(left: 5),
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[100],
                      //   border: Border.all(color: Colors.grey),
                      //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      // ),
                      child: Table(
                        columnWidths: {
                          0: FractionColumnWidth(0.09),
                          1: FractionColumnWidth(0.27),
                          2: FractionColumnWidth(0.26),
                          3: FractionColumnWidth(0.13),
                          4: FractionColumnWidth(0.125),
                          5: FractionColumnWidth(0.125)
                        },
                        border: TableBorder.all(color: Colors.pink[200]),
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('SL.ON',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('MACHINE NUMBER',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: Get.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('CALL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: Get.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Date',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: Get.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Time In',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: Get.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Time Out',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: Get.width * 0.02,fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]),  for (var i = 0; i < history[index].length; i++) 
                          TableRow(children: [
                          
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text( i.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text( history[index][i]["machine"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(history[index][i]["line"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(history[index][i]["date"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(history[index][i]["time_in"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(history[index][i]["time_out"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: Get.width * 0.018,fontWeight: FontWeight.normal)),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  );
                }));
  }

  Widget infoWidget(String _title, String _value) {
    return Container(
      width: MediaQuery.of(context).size.width / 4.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: TextStyle(fontSize: Get.width * 0.021, color: Colors.grey),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "$_value",
            style: TextStyle(
              fontSize: Get.width * 0.025,
            ),
          )
        ],
      ),
    );
  }
}
