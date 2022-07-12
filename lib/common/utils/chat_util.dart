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