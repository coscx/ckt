import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_image_demo.dart';

Widget getCacheImage(
  String url,
) {
  return CustomCacheImage(url: url);
}

ExtendedNetworkImageProvider getCacheImageProvider(
  String url,
) {
  return ExtendedNetworkImageProvider(
    url,
    cache: false,
  );
}
