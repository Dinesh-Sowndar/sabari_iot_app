import 'package:IoT_App/pages/ch_page.dart';
import 'package:IoT_App/styles.dart';
import 'package:IoT_App/utils/form_validator.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SelectUser extends StatefulWidget {
  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  GlobalKey<FormState> _keyName = new GlobalKey();
  bool _validateName = false;
  String name;
  String selected;
  List names = [];
  //  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> _formKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    names = GetStorage().read("machine") ?? [];
  }

  Widget addName() {
    name = "";
    return StatefulBuilder(builder: (context, _setState) {
      return FadeInDown(
        duration: Duration(milliseconds: 300),
        child: Dialog(
          backgroundColor: Colors.blueGrey[50],
          insetPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: new Form(
                key: _keyName,
                autovalidate: _validateName,
                child: Container(
                  width: 320,
                  color: Colors.blueGrey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Add User",
                              style: TextStyle(
                                // decoration: TextDecoration.underline,
                                color: Colors.grey[700],
                                fontSize: Get.width * 0.028,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // height: 48,
                        width: Get.width / 1.3,
                        decoration: input_container_style,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: Get.width * 0.025,
                              color: Colors.grey[800]),
                          onSaved: (value) {
                            name = value;
                          },
                          validator: (value) => validateRequired(value, "Name"),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: Get.width * 0.025,
                              ),
                              hintText: "Enter Name"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              if (_keyName.currentState.validate()) {
                                _keyName.currentState.save();

                                print(name);
                                _setState(() {
                                  names.add(name);
                                });

                                _formKey.currentState.reset();
                                  selected = null;
                                  GetStorage().write("machine", names);
                                Get.back();
                              } else {
                                setState(() {
                                  _validateName = true;
                                });
                              }
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.red[100],
                                  child: Icon(
                                    Icons.check_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Confirm",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Get.width * 0.025,
                                  ),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.green[200],
                                  child: Icon(Icons.close_rounded,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Get.width * 0.025,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget removeName() {
    return StatefulBuilder(builder: (context, _setState) {
      return FadeInDown(
        duration: Duration(milliseconds: 300),
        child: Dialog(
          backgroundColor: Colors.blueGrey[50],
          insetPadding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Container(
                width: 320,
                color: Colors.blueGrey[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Remove User",
                            style: TextStyle(
                              // decoration: TextDecoration.underline,
                              color: Colors.grey[700],
                              fontSize: Get.width * 0.028,
                            ),
                          ),
                        ],
                      ),
                    ),
                    names.length == 0
                        ? Center(
                            child: Text(
                            "No User",
                            style: TextStyle(
                              // decoration: TextDecoration.underline,
                              color: Colors.red[300],
                              fontSize: Get.width * 0.025,
                            ),
                          ))
                        : ListView.builder(
                            itemCount: names.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(names[index],
                                      style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        // color: Colors.red[300],
                                        fontSize: Get.width * 0.025,
                                      )),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 22,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _formKey.currentState.reset();
                                        _setState(() {
                                          names.remove(names[index]);
                                        });
                                        GetStorage().write("machine", names);
                                      })
                                ],
                              );
                            },
                          ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return null;
      },
          child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Select the Machine".toUpperCase()),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.green,
                   shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                textColor: Colors.white,
                onPressed: () {
                  Get.dialog(addName(), barrierDismissible: true).then((value) {
                    Get.offAll(SelectUser(),transition: Transition.noTransition);
                  });
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: Get.width * 0.025),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                   shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  print(names);
                  Get.dialog(removeName(), barrierDismissible: true).then((value) => 
                  Get.offAll(SelectUser(),transition: Transition.noTransition));
                },
                child: Text(
                  "Delete",
                  style: TextStyle(fontSize: Get.width * 0.025),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/device1.jpeg",
                  width: Get.width * 0.28,
                  height: Get.width * 0.28,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    // color: Colors.grey,
                    width: Get.width * 0.35,
                      decoration: BoxDecoration(
                    color: Colors.yellow[400],
                              // border: Border.all(color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                    height:60,
                    // padding: EdgeInsets.all(20.0),
                    child: Container(
                        decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5,1,5,1),
                        child: Center(
                          child: DropdownButtonFormField(
                              // hint: Text(""),
                              key: _formKey,
                              dropdownColor: Colors.yellow[400],
                              decoration: InputDecoration.collapsed(
                                hintText: 'Machine number'.toUpperCase(),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              isExpanded: true,
                              // isDense: false,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                              value: selected,
                              items: names
                                  .map((e) => new DropdownMenuItem(
                                        value: e,
                                        child: new Text(e),
                                      ))
                                  .toList(),

                              //  [
                              //   DropdownMenuItem(
                              //     child: Text("Sabari"),
                              //     value: "Sabari",
                              //   ),
                              //   DropdownMenuItem(
                              //     child: Text("Dinesh"),
                              //     value: "Dinesh",
                              //   ),
                              //   DropdownMenuItem(child: Text("Karthi"), value: "Karthi"),
                              // ],

                              onChanged: (value) {
                                Get.to(ChPage(
                                  name: value,
                                ));
                                // setState(() {
                                //   _value = value;
                                // });
                              }),
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/device3.jpeg",
                  width: Get.width * 0.28,
                  height: Get.width * 0.28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
