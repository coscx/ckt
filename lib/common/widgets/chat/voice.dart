import 'dart:async';
import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

import '../../../common/utils/permission.dart';
import 'package:record/record.dart';
typedef RecordFc = Function(int sec, String path);
class Voice {
  static const _dir = "voice";
  static const _ext = ".m4a";
  late String _path;
  int _long = 0;
  late final int _tag;
  final RecordFc _callback;
   Timer? timer =Timer.periodic(
  const Duration(milliseconds: 1000), (t) async {});
  bool _isPlaying = false;
  bool _isRecording = false;
  final _audioRecorder = Record();
  final _voicePlayer = AudioPlayer();
  bool get  isPlaying => _isPlaying;
  bool get  isRecording => _isRecording;

  Voice(this._callback) : _tag = _now();
  Future<void> init() async {
    requestPermission();
  }

  void requestPermission() async {
    checkPermission();
  }

  getPermission() {
    requestPermissions();
  }

  startRecord(Function(String p1, String p2) callBack) async {
    Vibration.vibrate(duration: 50);
    try {
      requestPermission();
      print('===>  获取了权限');
      if (await _audioRecorder.hasPermission()) {
        var path = (await getApplicationDocumentsDirectory()).path;
        _path = '$path/$_dir/$_tag$_ext';
        File file = File(_path);
        if (!(await file.exists())) {
          await file.create(recursive: true);
        }
        _long = _now();
        _audioRecorder.start(path: _path);
        _isRecording =true;
      }
      String audioIconPath = "";
      timer = Timer.periodic(
          const Duration(milliseconds: 100), (t) async {
        var d = await _audioRecorder.getAmplitude();
        double volume = d.current;
        volume =volume.abs();
        //print(volume);
        if (volume <= 0) {
          audioIconPath = '';
        } else if (volume > 0 && volume < 12) {
          audioIconPath = 'audio_player_3';
        } else if (volume > 12 &&volume < 22) {
          audioIconPath = 'audio_player_2';
        } else if (volume > 22 && volume < 32) {
          audioIconPath = 'audio_player_1';
        }

        callBack(_path, audioIconPath);
      });

    } catch (err) {
      stopRecorder();
      _isRecording =false;
    }
  }

  /// 取消录音监听
  /// 结束录音
  stopRecorder() async {
    try {
      if (await _audioRecorder.isRecording()) {
        _long = (_now() - _long) ~/ 1000;
        _audioRecorder.stop();
        _callback(_long, _path);
      }
      print('===> stopRecorder');

    } catch (err) {
      print('stopRecorder error: $err');
    }
    timer?.cancel();
    _isRecording =false;
  }


  /// 开始播放
  Future<void> startPlayer(
    String path,
  ) async {
    try {
      var p = await fileExists(path);
      if (p == "") {
       await _voicePlayer.setFilePath(path);
      } else {
        await _voicePlayer.setUrl(p);
      }
      await _voicePlayer.load();
      _isPlaying=true;
      _voicePlayer.playerStateStream.listen((state) {

        switch (state.processingState) {
          case ProcessingState.idle:
          case ProcessingState.loading:
          case ProcessingState.buffering:
          case ProcessingState.ready:
            break;
          case ProcessingState.completed:

              if (_isPlaying) {
                _isPlaying = false;
                 //_voicePlayer.stop();
              }

            break;
        }
      });
       _voicePlayer.play();
      print('===> startPlayer');
    } catch (err) {
      print('==> 错误: $err');
    }
  }

  /// 结束播放
  Future<void> stopPlayer() async {
    try {
       _voicePlayer.stop();
       _voicePlayer.dispose();
      print('===> stopPlayer');

    } catch (err) {
      print('==> 错误: $err');
    }
  }

  /// 判断文件是否存在
  Future<String> fileExists(String paths) async {
    if (paths.startsWith("http://localhost")) {
      //File f =   await _getLocalFile(path.basename(paths));
      return "";
    } else if (paths.startsWith("http")) {
      return paths;
    }

    return paths;
  }
  static int _now() => DateTime.now().millisecondsSinceEpoch;
}
