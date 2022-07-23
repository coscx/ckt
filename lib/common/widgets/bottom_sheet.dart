import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class PhotoShareBottomSheet extends StatelessWidget {
  const PhotoShareBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
       // filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
            color: Colors.blue,
            child: Container(
              //backgroundColor: Colors.transparent,
              //appBar: appBar(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                //physics: ClampingScrollPhysics(),
                //controller: ModalScrollController.of(context),
                children: <Widget>[
                  // Container(
                  //
                  //   child: Stack(
                  //     children: [
                  //
                  //
                  //       Container(
                  //           padding:  EdgeInsets.only(
                  //               top: 80.h,
                  //               left: 100.w,
                  //               right: 100.w,
                  //               bottom: 0.w
                  //           ),
                  //         child: Container(
                  //           height: 100.h,
                  //           width: 100.w,
                  //
                  //           child: Image.asset(
                  //               "assets/packages/images/chat_matching_radar.png"),
                  //         )
                  //       ),
                  //       Container(
                  //           padding:  EdgeInsets.only(
                  //               top: 80.h,
                  //               left: 100.w,
                  //               right: 100.w,
                  //               bottom: 0.w
                  //           ),
                  //           //height: 500.h,
                  //           child: Container(
                  //             height: 100.h,
                  //             width: 100.w,
                  //             //alignment: FractionalOffset.topLeft,
                  //             child:    Container(),
                  //           )
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                  Container(
                    child: Container(
                      //height: 700.h,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.w),
                              topRight: Radius.circular(20.w))),
                      //margin: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // Row(
                            //   children: <Widget>[
                            //     SizedBox(
                            //       width: 30.w,
                            //     ),
                            //     Column(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: <Widget>[
                            //           Container(
                            //             height: 160.h,
                            //             width: 160.w,
                            //             alignment: FractionalOffset.topLeft,
                            //             child: Image.asset(
                            //                 "assets/packages/images/tab_match.webp"),
                            //           ),
                            //         ]),
                            //   ],
                            // ),
                            Container(
                              //height: 350.h,
                              //color: Colors.red,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.w)),
                              margin: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
                              child: Container(
                                  //physics: const BouncingScrollPhysics(),
                                  child: Column(children: <Widget>[

                                    Wrap(
                                      spacing: 40.w,
                                      runSpacing: 0.w,
                                      children: <Widget>[
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),
                                        buildButton("...",
                                            "assets/packages/images/tab_match.webp","assets/packages/images/tab_match.webp"),

                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 100.h,
                                    // ),
                                  ])),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget buildButton(String name, String url,String bg) {
    return Stack(
      children: [
        Container(
            color: Colors.white,
            height: 160.h,
            width: 130.w,
            child: Column(children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Image.asset(bg),
              SizedBox(
                height: 8.h,
              ),
              Text(name,
                  style: TextStyle(
                      color: Colors.black.withAlpha(88),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.h,
              )
            ])),
        Container(
            color: Colors.white,
            height: 160.h,
            width: 130.w,
            child: Column(children: <Widget>[
              SizedBox(
                height: 2.h,
              ),
              Image.asset(url),
              SizedBox(
                height: 8.h,
              ),
              Text(name,
                  style: TextStyle(
                      color: Colors.black.withAlpha(88),
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 0.h,
              )
            ])),


      ],
    );
  }

  Widget sliverContactsSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 132.h,
        padding: EdgeInsets.only(top: 12.h),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final person = people[index];
            return Container(
              width: 72.w,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 8.h),
                  Text(
                    person.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11.sp),
                  )
                ],
              ),
            );
          },
          itemCount: people.length,
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 74.w),
      child: ClipRect(
        child: Container(
          //filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: CupertinoTheme.of(context)
                .scaffoldBackgroundColor
                .withOpacity(0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 18.w),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(top: 14.h),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 50.sp,
                              color: Colors.black.withAlpha(66),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[],
                      )),
                      SizedBox(width: 14.w),
                    ],
                  ),
                ),
                Container(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String title;
  final String imageUrl;

  Item(this.title, this.imageUrl);
}

final people = [
  Item('MacBook Pro', 'assets/MacBook.jpg'),
  Item('Jaime Blasco', 'assets/jaimeblasco.jpeg'),
  Item('Mya Johnston', 'assets/person1.jpeg'),
  // https://images.unsplash.com/photo-1520813792240-56fc4a3765a7'
  Item('Maxime Nicholls', 'assets/person4.jpeg'),
  //https://images.unsplash.com/photo-1568707043650-eb03f2536825'
  Item('Susanna Thorne', 'assets/person2.jpeg'),
  //https://images.unsplash.com/photo-1520719627573-5e2c1a6610f0
  Item('Jarod Aguilar', 'assets/person3.jpeg')
  //https://images.unsplash.com/photo-1547106634-56dcd53ae883
];



class SimpleSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  SimpleSliverDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(height: height, child: child);
  }

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
