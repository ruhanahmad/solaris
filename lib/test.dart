import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerScreen extends StatefulWidget {


  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();


  // @override
  // void initState() {
  //   super.initState();
  //   audioPlayer.onPlayerStateChanged.listen((event) {
  //     setState(() {
  //       audioPlayerState = event;
  //     });
  //   });
  // }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the audio player state
            // Text('Player State: $audioPlayerState'),
            // Play button
            ElevatedButton(
              onPressed: () async{
              await  audioPlayer.play(UrlSource("https://firebasestorage.googleapis.com/v0/b/solaris-2af35.appspot.com/o/profilepics%2Faudio1697154064774?alt=media&token=14ddba1d-44a4-4159-9c08-1bb73353c175"), );
              },
              child: Text('Play'),
            ),
            // Pause button
            ElevatedButton(
              onPressed: () {
                audioPlayer.pause();
              },
              child: Text('Pause'),
            ),
            // Stop button
            ElevatedButton(
              onPressed: () {
                audioPlayer.stop();
              },
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}

