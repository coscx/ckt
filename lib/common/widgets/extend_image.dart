import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'custom_image_demo.dart';

Widget getCacheImage(
  String url,
) {
  return CustomCacheImage(url:url);
  // return ExtendedImage.network(
  //   url,
  //   fit: BoxFit.cover,
  //   //width: 400.w,
  //   //height: 400.h,
  //   handleLoadingProgress: true,
  //   clearMemoryCacheIfFailed: true,
  //   clearMemoryCacheWhenDispose: true,
  //   cache: false,
  //   loadStateChanged: (ExtendedImageState state) {
  //     if (state.extendedImageLoadState == LoadState.loading) {
  //       final ImageChunkEvent? loadingProgress = state.loadingProgress;
  //       final double? progress = loadingProgress?.expectedTotalBytes != null
  //           ? loadingProgress!.cumulativeBytesLoaded /
  //               loadingProgress.expectedTotalBytes!
  //           : null;
  //       return Center(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: <Widget>[
  //             SizedBox(
  //               width: 150.w,
  //               child: LinearProgressIndicator(
  //                 value: progress,
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10.w,
  //             ),
  //             Text('${((progress ?? 0.0) * 100).toInt()}%'),
  //           ],
  //         ),
  //       );
  //     }
  //     if (state.extendedImageLoadState == LoadState.completed) {
  //       return FadeTransition(
  //         opacity: _controller,
  //         child: ExtendedRawImage(
  //           image: state.extendedImageInfo?.image,
  //           width: 300,
  //           height: 200,
  //         ),
  //       );
  //     }
  //     return null;
  //   },
  // );
}

ExtendedNetworkImageProvider getCacheImageProvider(
  String url,
) {
  return ExtendedNetworkImageProvider(
    url,
    cache: false,
  );
}
