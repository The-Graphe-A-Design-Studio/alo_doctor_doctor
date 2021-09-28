import 'dart:math';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:alo_doctor_doctor/api/agoraApis.dart';
import 'package:alo_doctor_doctor/api/login.dart';
import 'package:alo_doctor_doctor/models/doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "4795c84bf0ac47299f693efe2b8553db";
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class VideoCallingScreen extends StatefulWidget {
  final String pId;

  VideoCallingScreen(this.pId);

  @override
  _VideoCallingScreenState createState() => _VideoCallingScreenState();
}

class _VideoCallingScreenState extends State<VideoCallingScreen> {
  int _remoteUid;
  RtcEngine _engine;
  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      muteAudio = false,
      muteVideo = false;
  bool remoteUserMicMute = false,
      remoteUserVideoMute = false;
  AgoraApis _agoraApis = AgoraApis();
  String token;
  String channelName;
  String channelId;
  var doctor;

  Random _rnd = Random();

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void initState() {
    super.initState();
    // getAgoraToken().then((value) => initForAgora());
    initForAgora();
  }

  Future<void> getAgoraToken() async {
    var tokenBody =
    await _agoraApis.getAgoraToken(getRandomString(20), widget.pId);
    print('token Body from videoPage' + tokenBody.toString());

    if (tokenBody['success'] == 1 || tokenBody['success'] == 2) {
      setState(() {
        token = tokenBody['channel']['access_token'];
        channelName = tokenBody['channel']['channel_name'];
        channelId = tokenBody['channel']['id'].toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Unable to get Video Call Token, Please check your internet Connection and try again."),
      ));
    }
  }

  Future<void> initForAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    doctor = await LoginCheck().UserInfo();

    print('***************** Agore Init 1 ****************');

    //create the engine
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(appId));

    print('***************** Agore Init 2 ****************');

    await _engine.enableVideo();

    print('***************** Agore Init 3 ****************');

    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('***************** Agore Init 4 ****************');
          print("local user $uid joined");
        },
        tokenPrivilegeWillExpire: (token) async {
          await getAgoraToken();
          await _engine.renewToken(token);
        },
        userJoined: (int uid, int elapsed) {
          print('***************** Agore Init 5 ****************');
          print("remote user $uid joined");
          _engine.enableVideo();
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('***************** Agore Init 6 ****************');
          print("remote user $uid left channel");
          setState(() {
            _remoteUid = null;
          });
          _userLeftTheCall();
        },
        userMuteVideo: (int uid, bool isMute) {
          print('Audio Mutted');
          setState(() {
            remoteUserVideoMute = isMute;
          });
        },
        userMuteAudio: (int uid, bool isMute) {
          print('Audio Mutted');
          setState(() {
            remoteUserMicMute = isMute;
          });
        },
      ),
    );

    await getAgoraToken();
    await _engine.joinChannel(token, channelName, null, doctor['id']);
    // await getAgoraToken().then((value) async {
    //   await _engine.joinChannel(token, channelName, null, 70);
    // });
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Agora Video Call'),
        // ),

        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: _renderRemoteVideo(),
              ),
              if (remoteUserVideoMute)
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 10,
                    sigmaY: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Center(
                      child: Text(
                          'Patient video Paused',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              if (remoteUserMicMute)
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: Text(
                      'Patient Mic Muted',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 100,
                  height: 120,
                  child: Center(
                    child: _renderLocalPreview(),
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                right: 8,
                left: 8,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        await _agoraApis.leaveChannel(channelId);
                        await _engine?.leaveChannel();
                        Navigator.pop(context);

                        // var tokenBody = await _serverHandler.leaveChannel(channelId);
                        // print('Leave Channel Body '+tokenBody.toString());
                        //
                        // if (tokenBody['success'] == 1) {
                        //   setState(() {
                        //     token = '';
                        //   });
                        //   _engine.leaveChannel();
                        //   Navigator.pop(context);
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     content: Text("Some error occurred."),
                        //   ));
                        // }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red),
                        child: Icon(
                          Icons.call_end,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: this._switchCamera,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Icon(
                          Icons.flip_camera_android_rounded,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: this._onToggleMuteVideo,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Icon(
                          muteVideo
                              ? Icons.videocam_off_outlined
                              : Icons.videocam_outlined,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: this._onToggleMute,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Icon(
                          muteAudio
                              ? Icons.mic_off_outlined
                              : Icons.mic_none_outlined,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // current user video
  Widget _renderLocalPreview() {
    return RtcLocalView.SurfaceView();
  }

  // remote user video
  Widget _renderRemoteVideo() {
    // return RtcRemoteView.SurfaceView(uid: 32);
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Text(
        'Please wait, patient is joining shortly',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }
  }

  // _leaveChannel() async {
  //   await _engine.leaveChannel();
  //   Navigator.pop(context);
  // }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  void _onToggleMute() {
    setState(() {
      muteAudio = !muteAudio;
    });
    _engine.muteLocalAudioStream(muteAudio);
  }

  void _onToggleMuteVideo() {
    setState(() {
      muteVideo = !muteVideo;
    });
    _engine.muteLocalVideoStream(muteVideo);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit exit Video Call?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () async {
              await _agoraApis.leaveChannel(channelId);
              await _engine?.leaveChannel();
              Navigator.of(context).pop(true);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  _userLeftTheCall() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Patient Left'),
        content: new Text('Patient left this call please join Again'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await _agoraApis.leaveChannel(channelId);
              await _engine?.leaveChannel();
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
              Navigator.of(context).pop(true);
            },
            child: new Text('Okay'),
          ),
        ],
      ),
    )) ?? false;
  }

}
