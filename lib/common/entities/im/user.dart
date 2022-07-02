class ImUser {
  String uid;
  String username;
  String avatarUrl;

  ImUser({required this.uid, required this.username, this.avatarUrl = 'http://thirdqq.qlogo.cn/g?b=oidb&k=h22EA0NsicnjEqG4OEcqKyg&s=100'});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['username'] = username;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
