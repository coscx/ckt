import 'package:flutter/material.dart';
import 'package:flutter_ckt/common/widgets/extend_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../../common/apis/common.dart';
import '../../../common/services/storage.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import 'index_bar.dart';
import 'select_result_data.dart';

class _SelectCell extends StatelessWidget {
  final int? id; //id
  final String? imageUrl; //图片 URL
  final String? name; //昵称
  final String? groupTitle; //组头标题
  final String? imageAssets; //本地图片地址
  final Function(dynamic) onResendClick;

  const _SelectCell(
      {this.imageUrl,
      this.name,
      this.groupTitle,
      this.imageAssets,
      this.id,
      required this.onResendClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onResendClick({"id": id, "name": name});
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
                      image: getImage(imageUrl, imageAssets),
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

  ImageProvider getImage(String? imageUrl, imageAssets) {
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

class SelectPage extends StatefulWidget {
  final Function(dynamic) onResendClick;
  final Function(dynamic) onHide;
  final int type;
  const SelectPage({Key? key, required this.onResendClick, required this.type, required this.onHide}) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  final List<Friends> _headerData = [];
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
    List<Friends> dr = <Friends>[];
    String roleKey = StorageService.to.getString("roleKey");
    if (roleKey == "super") {
       if (widget.type ==1){
         var d = await CommonAPI.getSuperEmployees({});
         if (d.data != null && d.data?.data != null) {
           dr = d.data!.data!.map((e) {
             return Friends(
                 imageAssets: 'assets/images/friend/tag.png',
                 name: e.nickname,
                 indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                     .substring(0, 1)
                     .toUpperCase(),
                 sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                 id: e.userid);
           }).toList();
       }

      }
       if (widget.type ==2){
         var d = await CommonAPI.getSuperStaff({});
         if (d.data != null && d.data?.data != null) {
           dr = d.data!.data!.map((e) {
             return Friends(
                 imageAssets: 'assets/images/friend/tag.png',
                 name: e.nickname,
                 indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                     .substring(0, 1)
                     .toUpperCase(),
                 sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                 id: e.userid);
           }).toList();
         }

       }
       if (widget.type ==3){
         var d = await CommonAPI.getSuperChannel({});
         if (d.data != null && d.data?.data != null) {
           dr = d.data!.data!.map((e) {
             return Friends(
                 imageAssets: 'assets/images/friend/tag.png',
                 name: e.searchvalue.toString(),
                 indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                     .substring(0, 1)
                     .toUpperCase(),
                 sex: 0,
                 id: e.cnid);
           }).toList();
         }

       }
       if (widget.type ==4){
         var d = await CommonAPI.getSuperDirector({});
         if (d.data != null && d.data?.data != null) {
           dr = d.data!.data!.map((e) {
             return Friends(
                 imageAssets: 'assets/images/friend/tag.png',
                 name: e.nickname.toString(),
                 indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                     .substring(0, 1)
                     .toUpperCase(),
                 sex: 0,
                 id: e.userid);
           }).toList();
         }

       }


    } else if (roleKey == "salesman") {

      if (widget.type ==2){
        var d = await CommonAPI.getSaleManStaff({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname,
                indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                    .substring(0, 1)
                    .toUpperCase(),
                sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                id: e.userid);
          }).toList();
        }

      }
      if (widget.type ==3){
        var d = await CommonAPI.getSaleManChannel({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.cnname.toString(),
                indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                    .substring(0, 1)
                    .toUpperCase(),
                sex: 0,
                id: e.cnid);
          }).toList();
        }

      }

    } else if (roleKey == "director") {
      if (widget.type ==1){
        var d = await CommonAPI.getManageEmployees({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname,
                indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                    .substring(0, 1)
                    .toUpperCase(),
                sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                id: e.userid);
          }).toList();
        }

      }
      if (widget.type ==2){
        var d = await CommonAPI.getManageStaff({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname,
                indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                    .substring(0, 1)
                    .toUpperCase(),
                sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                id: e.userid);
          }).toList();
        }

      }
      if (widget.type ==3){
        var d = await CommonAPI.getManageChannel({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.searchvalue.toString(),
                indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                    .substring(0, 1)
                    .toUpperCase(),
                sex: 0,
                id: e.cnid);
          }).toList();
        }

      }
      if (widget.type ==4){
        var d = await CommonAPI.getManageSubordinate({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname.toString(),
                indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                    .substring(0, 1)
                    .toUpperCase(),
                sex: 0,
                id: e.userid);
          }).toList();
        }

      }
    } else if (roleKey == "administration") {
      if (widget.type ==1){
        var d = await CommonAPI.getAdministrativeEmployees({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname,
                indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                    .substring(0, 1)
                    .toUpperCase(),
                sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                id: e.userid);
          }).toList();
        }

      }
      if (widget.type ==2){
        var d = await CommonAPI.getAdministrativeStaff({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.nickname,
                indexLetter: PinyinHelper.getFirstWordPinyin(e.nickname)
                    .substring(0, 1)
                    .toUpperCase(),
                sex: e.sex ==null ? 0: int.parse(e.sex.toString()),
                id: e.userid);
          }).toList();
        }

      }
      if (widget.type ==3){
        var d = await CommonAPI.getAdministrativeChannel({});
        if (d.data != null && d.data?.data != null) {
          dr = d.data!.data!.map((e) {
            return Friends(
                imageAssets: 'assets/images/friend/tag.png',
                name: e.cnname.toString(),
                indexLetter: PinyinHelper.getFirstWordPinyin(e.searchvalue.toString())
                    .substring(0, 1)
                    .toUpperCase(),
                sex: 0,
                id: e.cnid);
          }).toList();
        }

      }
    } else {

    }
    if (dr.length > 0) {
      _listDatas.addAll(dr);
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
      if (mounted) setState(() {});
    }
  }
  @override
  void dispose() {
    super.dispose();
    Future.delayed(Duration(milliseconds: 1),(){
      widget.onHide(true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '请选择',
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
    bool isShowT = index - _headerData.length > 0 &&
        _listDatas[index - _headerData.length].indexLetter ==
            _listDatas[index - _headerData.length - 1].indexLetter;
    return _SelectCell(
      id: _listDatas[index - 0].id,
      imageUrl: _listDatas[index - 0].imageUrl,
      imageAssets: _listDatas[index - 0].sex == 0
          ? 'assets/images/default/ic_user_male.png'
          : 'assets/images/default/ic_user_female.png',
      name: _listDatas[index - 0].name,
      groupTitle: isShowT ? null : _listDatas[index - 0].indexLetter,
      onResendClick: (data) {
        widget.onResendClick(data);
        Navigator.pop(context);
      },
    );
  }
}
