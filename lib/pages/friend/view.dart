import 'package:flutter/material.dart';
import 'package:flutter_ckt/pages/friend/widget/friends_page.dart';
import 'package:get/get.dart';

import 'logic.dart';

class FriendPage extends StatelessWidget {
  final logic = Get.find<FriendLogic>();
  final state = Get.find<FriendLogic>().state;

  @override
  Widget build(BuildContext context) {
    return FriendsPage();
  }
}
