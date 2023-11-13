import 'package:flutter/material.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({Key? key}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool isCameraOn = true;
  bool isMicrophoneOn = true;
  bool isCallActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 320,
              height: 240,
              color: Colors.black, // Đây là nơi hiển thị video stream
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(isMicrophoneOn ? Icons.mic : Icons.mic_off),
                  onPressed: () {
                    setState(() {
                      isMicrophoneOn = !isMicrophoneOn;
                    });
                  },
                  color: isMicrophoneOn ? Colors.blue : Colors.red,
                  iconSize: 48,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(isCameraOn ? Icons.videocam : Icons.videocam_off),
                  onPressed: () {
                    setState(() {
                      isCameraOn = !isCameraOn;
                    });
                  },
                  color: isCameraOn ? Colors.blue : Colors.red,
                  iconSize: 48,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCallActive = !isCallActive;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: isCallActive ? Colors.red : Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  isCallActive ? 'END' : 'START',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
