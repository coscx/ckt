import 'package:flt_im_plugin/conversion.dart';
import 'package:get/get.dart';

import '../../common/routers/names.dart';
import '../../common/services/storage.dart';
import 'state.dart';

class FriendLogic extends GetxController {
  final FriendState state = FriendState();


  void onTap(int? id ,String? name) {

    var memberId = StorageService.to.getString("memberId");
    final Conversion model = Conversion.fromMap(
        {"memId": memberId, "cid": id!, "name": name});
    Get.toNamed(AppRoutes.Peer, arguments: model);

  }
}
