import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/widgets/extend_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lpinyin/lpinyin.dart';
import '../../../common/apis/common.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../logic.dart';
import 'child_page.dart';
import 'friends_data.dart';
import 'index_bar.dart';

class _FriendCell extends StatelessWidget {
  final int? id; //id
  final String? imageUrl; //图片 URL
  final String? name; //昵称
  final String? groupTitle; //组头标题
  final String? imageAssets; //本地图片地址
  const _FriendCell(
  {this.imageUrl, this.name, this.groupTitle, this.imageAssets,this.id});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final logic = Get.find<FriendLogic>();
        logic.onTap(id,name);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 30.w),
            height: groupTitle != null ? 50.h : 0,
            color: Color(0xffdddddd),
            child: groupTitle != null
                ? Text(
                    groupTitle!,
                    style: const TextStyle(color: Colors.grey),
                  )
                : null,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.w),
            color: Colors.white,
            child: Row(children: [
              Container(
                margin: EdgeInsets.all(20.w),
                width: 70.w,
                height: 60.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.w),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: getImage(imageUrl,imageAssets),
                    )),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: [
                        Container(
                          //margin: EdgeInsets.only(bottom: 12.w),
                          height: 80.h,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name!,
                            style:
                                TextStyle(fontSize: 32.sp, color: Colors.black),
                          ),
                        ),
                        Container(
                          height: 1.h,
                          color: Color(0xffeeeeee),
                        ), //下划线
                      ],
                    )),
              ), //昵称
            ]),
          ),
        ],
      ),
    );
  }

  ImageProvider getImage(String? imageUrl,imageAssets) {
    if (imageUrl == null) {
      return AssetImage(imageAssets);
    }
    return getCacheImageProvider(imageUrl);
  }

  Widget getImages() {
    if (imageUrl == null) {
      return Image.asset(imageAssets!);
    }
    return Image.network(imageUrl!);
  }
}

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final List<Friends> _headerData = [
    Friends(imageAssets: 'assets/images/friend/new_friend.png', name: '新的朋友'),
    Friends(imageAssets: 'assets/images/friend/group_chat.png', name: '群聊'),
    Friends(imageAssets: 'assets/images/friend/tag.png', name: '标签'),
    Friends(imageAssets: 'assets/images/friend/common.png', name: '公众号'),
  ];
  late final List<Friends> _listDatas = [];
  late ScrollController _scrollController;
  final double _cellHeight = 90.h;
  final double _groupHeight = 60.h;
  final Map _groupOffsetMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[0]: 0.0,
  };
  int page = 1;
  @override
  void initState() {
    _df();
    super.initState();
  }
  _df() async {
    _scrollController = ScrollController();
    var d = await CommonAPI.getGroupMembers(page);
    if (d.data != null && d.data?.data != null) {
      var dr = d.data!.data!.map((e) {
        return Friends(imageAssets: 'assets/images/friend/tag.png', name: e.nickName,indexLetter: PinyinHelper.getFirstWordPinyin(e.nickName).substring(0,1).toUpperCase(),sex: e.sex,id: e.userId);
      }).toList();
      _listDatas..addAll(dr);
      _listDatas.sort((Friends a, Friends b) {
        return a.indexLetter!.compareTo(b.indexLetter!);
      });
      var _groupOffset = _cellHeight * _headerData.length;
      for (int i = 0; i < _listDatas.length; i++) {
        if (i < 1) {
          _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
          _groupOffset += _cellHeight + _groupHeight;
        } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
          _groupOffset += _cellHeight;
        } else {
          _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
          _groupOffset += _cellHeight + _groupHeight;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ChildPage(
                        title: "添加好友",
                      )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 30.w),
              child: Image(
                image: AssetImage("assets/images/friend/icon_friends_add.png"),
                width: 45.w,
              ),
            ),
          )
        ],
        title: const Text(
          '通讯录',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ScrollConfiguration(
        behavior: DyBehaviorNull(),
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: _itemForRow,
              itemCount: _headerData.length + _listDatas.length,
              controller: _scrollController,
            ),
            IndexBar(indexBarCallBack: (String str) {
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: const Duration(microseconds: 100),
                    curve: Curves.easeIn);
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _itemForRow(BuildContext context, int index) {
    if (index < _headerData.length) {
      return _FriendCell(
        imageAssets: _headerData[index].imageAssets,
        name: _headerData[index].name,
      );
    } else {
      bool isShowT = index - _headerData.length > 0 &&
          _listDatas[index - _headerData.length].indexLetter ==
              _listDatas[index - _headerData.length - 1].indexLetter;
      return _FriendCell(
          id: _listDatas[index - 4].id,
          imageUrl: _listDatas[index - 4].imageUrl,
          imageAssets: _listDatas[index - 4].sex ==0 ?'assets/images/default/ic_user_male.png' :'assets/images/default/ic_user_female.png',
          name: _listDatas[index - 4].name,
          groupTitle: isShowT ? null : _listDatas[index - 4].indexLetter);
    }
  }
}
