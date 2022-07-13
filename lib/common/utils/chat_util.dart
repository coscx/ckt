import 'package:flt_im_plugin/message.dart';

import '../apis/common.dart';
import '../services/storage.dart';

Future<String>  getPeerName(String id) async {
  var name = StorageService.to.getString("peer_" + id.toString());
  if (name == "") {
    var result = await CommonAPI.getMemberInfo(id.toString());
    if (result.code == 200) {
      if (result.data != null) {
        await StorageService.to
            .setString("peer_" + id.toString(), result.data!.name);
        await StorageService.to
            .setInt("sex_" + id.toString(), result.data!.sex);
        name = result.data!.name;
      }
    }
  }
  return name;
}
int  getPeerSex(String id)  {
  int sex = StorageService.to.getInt("sex_" + id.toString());
  return sex;
}
Future<String> getGroupName(String id) async {
  var name = StorageService.to.getString("group_" + id.toString());
  if (name == "") {
    var result = await CommonAPI.getGroupInfo(id.toString());
    if (result.code == 200) {
      if (result.data != null) {
        await StorageService.to
            .setString("group_" + id.toString(), result.data!.name);
        name = result.data!.name;
      }
    }
  }
  return name;
}
List<Message> removeElement(List<Message> cc){
  List<Message> dd =<Message>[];
  for(int i=0;i<cc.length;i++){
    var  e= cc[i];
    if(e.type !=MessageType.MESSAGE_REVOKE){
      int m=0;
      for(int j=0;j<dd.length;j++){
        var  f= dd[j];
        if (e.content!['uuid'] ==f.content!['uuid']){
          m=1;
          break;
        }
      }
      if (m==1){
        continue;
      }
    }
    dd.add(e);
  }
  return dd;

}