import 'package:fengwuxp_openfeign_example/src/helpers/color_helpers.dart';
import 'package:flutter/material.dart';

class DemoSimpleView extends StatelessWidget {
  DemoSimpleView({String message = "Testing", Color color = const Color(0xFFFFFFFF), String result})
      : this.message = message,
        this.color = color,
        this.result = result;

  final String message;
  final Color color;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                height: 2.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 42.0),
              child: FlatButton(
                highlightColor: ColorHelpers.blackOrWhiteContrastColor(color).withAlpha(17),
                splashColor: ColorHelpers.blackOrWhiteContrastColor(color).withAlpha(34),
                onPressed: () {},
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: ColorHelpers.blackOrWhiteContrastColor(color),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
