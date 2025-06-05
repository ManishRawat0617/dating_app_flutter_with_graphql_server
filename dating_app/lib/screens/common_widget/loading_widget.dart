import 'package:dating_app/core/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  final List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // color: ColorConstants.primary,
      color: Color(0xFFFF477E).withOpacity(0.3),
      child: Center(
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme: const CupertinoThemeData(
              brightness: Brightness.dark,
            ),
          ),
          child: SizedBox(
            height: 80,
            child: LoadingIndicator(
              colors: _kDefaultRainbowColors,
              indicatorType: Indicator.ballRotateChase,
              strokeWidth: 4.0,
              pathBackgroundColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
