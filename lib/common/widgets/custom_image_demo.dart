import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomCacheImage extends StatefulWidget {
  final String url ;

  const CustomCacheImage({Key? key, required this.url}) : super(key: key);
  @override
  _CustomImageDemoState createState() => _CustomImageDemoState();
}

class _CustomImageDemoState extends State<CustomCacheImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String url = widget.url;
    return  Container(
              //margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ExtendedImage.network(
                url,
                fit: BoxFit.cover,
                cache: true,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      _controller.reset();
                      return Image.asset(
                        'assets/images/default/ic_user_none_round.png',
                        fit: BoxFit.cover,
                      );
                    case LoadState.completed:
                      _controller.forward();

                      ///if you don't want override completed widget
                      ///please return null or state.completedWidget
                      //return null;
                      //return state.completedWidget;
                      return FadeTransition(
                        opacity: _controller,
                        child: ExtendedRawImage(
                          fit: BoxFit.cover,
                          image: state.extendedImageInfo?.image,
                          width: 400.w,
                          height:200.h,
                        ),
                      );
                    case LoadState.failed:
                      _controller.reset();
                      //remove memory cached
                      state.imageProvider.evict();
                      return Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/gallery.png',
                              fit: BoxFit.fill,
                            ),
                             Positioned(
                              top: 30.h,
                              left: 15.w,
                              right: 0.0,
                              child: Text(
                                '加载失败',
                                style: TextStyle(fontSize: 18.sp,color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        // onTap: () {
                        //   state.reLoadImage();
                        // },
                      );
                  }
                },
              ),
            );

  }
}
