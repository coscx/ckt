import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

const _KEY = "AesAesAesAesAes1";
const _IV = "0000000000000000";
const public_key ="LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUEya09ZekViMDlLeVFHT29qKzR3bgp4M3lsazRZcVBtc0JqZ1VvZkhadDZibkxHVk44aER6MFduWnF6VS9mb0NZYk1RazRaWUNjZGFNaXdhS2tGSXN4CjVmbWwzdFoxNDZseXU3UEpycmRJeDMwYVdBZ1BtRWNzVUpsSU96ZkgzYk9yMTIwOXR3d0RHSXdob2h3eGlKQWwKSFVmeUxBK1JwcWFydmhIUlEzRHhHWXB3ck5rdnpQTXd2ZjdXRjkyOENOMEgvRCsyU2Z6dEQraFp4cStiS21ITApVNmdYOTNZV29GempTMnZxMFZZSnBQMTNMNHcvQlZoNGJNRlJiMEpodnpLTW16bHEwbUFqRVdGY20xeTFYU0ozCkUzdXJnS1Y5YWlkWjBIWDBnU3JIcEFMNG9MQ01HemNOK1BrNUM1dEkyMHRKS2JxbERab1pvV1ovbkxsSGdvcjkKZlFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t";
class EncryptUtils {
  static Future<String> enc(String api,Map<String, dynamic> data) async {
    int t = DateTime.now().millisecondsSinceEpoch;
    Map<String, dynamic> inData = {"timestamp":t,"url":api};
    inData.addAll(data);
    var secret = getRandString();
    var rasResult = await EncryptUtils.encodeRSAString(secret);
    var args = await EncryptUtils.aesEncrypt(json.encode(inData),secret);
    var formData = {"encode":args,"cmb":rasResult};
    return json.encode(formData);
  }

  static String encodeBase64(String data) {
    return base64Encode(utf8.encode(data));
  }


  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }


  static String encodeMd5(String plainText) {
    return (plainText);
  }

  //AES加密
  static aesEncrypt(String plainText,String  keys ) {
    try {
      final key = Key.fromUtf8(keys);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (err) {
      print("aes encode error:$err");
      return plainText;
    }
  }

  //AES解密
  static dynamic aesDecrypt(encrypted) {
    try {
      final key = Key.fromUtf8(_KEY);
      final iv = IV.fromUtf8(_IV);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
      final decrypted = encrypter.decrypt64(encrypted, iv: iv);
      return decrypted;
    } catch (err) {
      print("aes decode error:$err");
      return encrypted;
    }
  }

  static Future<String> encodeRSAString(String content) async{
    Uint8List publicKeys = base64.decode(public_key);
    dynamic  publicKey = RSAKeyParser().parse(utf8.decode(publicKeys));
    final encrypter = Encrypter(RSA(publicKey: publicKey ));

    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      }
      else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
//       return await encrypter.encrypt(content).base64.toUpperCase();
  }

  static Future<String> decodeRSAString(String content) async{
    Uint8List publicKeys = base64.decode(public_key);
    dynamic  publicKey = RSAKeyParser().parse(utf8.decode(publicKeys));
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    Uint8List sourceBytes = base64.decode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 128;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      Uint8List item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.decryptBytes(Encrypted(item)));
    }
    return utf8.decode(totalBytes);
//        return await encrypter.decrypt(Encrypted.fromBase64(content));
  }

  static String getRandString(){
    String alphabet = '1234567890qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strLength = 16; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strLength; i++) {
    //    right = right + (min + (Random().nextInt(max - min))).toString();
    left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return(left);
  }

}