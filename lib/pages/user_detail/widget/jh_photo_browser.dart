import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/photo_view/photo_view_gallery.dart';
import '../../../common/widgets/photo_view/src/photo_view_computed_scale.dart';
import '../../../common/widgets/photo_view/src/utils/photo_view_hero_attributes.dart';
const Color _selColor = Colors.white;
const Color _otherColor = Colors.grey;

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class JhPhotoBrowser extends StatefulWidget {
  List imgDataArr = [];
  int index;
  String? heroTag;
  PageController? controller;
  GestureTapCallback? onLongPress;
  bool isHiddenClose;
  bool isHiddenTitle;

  JhPhotoBrowser({Key? key,

    required this.imgDataArr,
    this.index = 0,
    this.onLongPress,
    this.controller,
    this.heroTag,
    this.isHiddenClose = false,
    this.isHiddenTitle = false,
  }) : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _JhPhotoBrowserState createState() => _JhPhotoBrowserState();
}

class _JhPhotoBrowserState extends State<JhPhotoBrowser> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light, // Status bar
          ),
    ),
    ),
    child:Scaffold(
      body: _body(),
    ));
  }

  Widget _body() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
              color: Colors.black,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                onLongPress: () {
                  widget.onLongPress!();
                },
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    String _imgURL = widget.imgDataArr[index];
                    ImageProvider _picture;
                    if(_imgURL.startsWith('http')){
                      _picture = NetworkImage(_imgURL);
                    }else{
                      _picture =AssetImage(_imgURL);
                    }
                    return PhotoViewGalleryPageOptions(
                      imageProvider: _picture,
                      heroAttributes: widget.heroTag != null
                          ? PhotoViewHeroAttributes(tag: widget.heroTag!)
                          : null,
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 2,
                    );
                  },
                  itemCount: widget.imgDataArr.length,
                  // loadingChild: Container(),
                  backgroundDecoration: null,
                  pageController: widget.controller,
                  enableRotation: false,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              )),
        ),
        Positioned(
          top: 20.h,
          left: 0,
          right: 0,
          height: 30,
          child: Offstage(
            offstage: widget.imgDataArr.length == 1 || widget.isHiddenTitle,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.imgDataArr.length}",
                  style: TextStyle(color: Colors.white, fontSize: 32.sp)),
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          right: 10,
          height: 30,
          child: Offstage(
            offstage: widget.isHiddenClose,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                Icons.close,
                size: 60.sp,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: widget.imgDataArr.length == 1 ? 0 : 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imgDataArr.length,
                  (i) => GestureDetector(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3.5),
                        child: CircleAvatar(
//                      foregroundColor: Theme.of(context).primaryColor,
                          radius: 3.5,
                          backgroundColor:
                              currentIndex == i ? _selColor : _otherColor,
                        )),
                  ),
                ).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
