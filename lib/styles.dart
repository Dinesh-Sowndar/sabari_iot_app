import 'package:flutter/material.dart';

final input_container_style =  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(1, 3), // changes position of shadow
              ),
            ],
          );

final input_text_styl= TextStyle(fontSize: 14, color: Colors.grey[800]);