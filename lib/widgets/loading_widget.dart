import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget LoadingWidget() {
  return Dialog(
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100,
          child: SizedBox(
            height: 25,
            child: SpinKitThreeBounce(
              color: Colors.green,
              size: 25.0,
            ),
          ),
        )),
  );
}
