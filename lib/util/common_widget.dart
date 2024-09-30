import 'package:bloc_tutorial/util/const_string.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonWidget {
  static Widget commonShimmer(
      {required double width, required double height, required double radius}) {
    return Shimmer.fromColors(
        baseColor: lightGrey,
        highlightColor: Colors.grey,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
