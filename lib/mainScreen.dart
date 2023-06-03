import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piano_app_gsg/piano.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  AudioPlayer p = AudioPlayer();
  String music = 'pianomusic';

  void playMusic() {
    p.play(AssetSource('music/$music.wav'));
  }

  @override
  void initState() {
    super.initState();
    deviceDirection();
    playMusic();
  }

  void startPiano(int pianoType) {
    p.stop();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => piano(pianoType)));
  }

  Future deviceDirection() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            p.stop();
            if (value == 0) {
              music = 'pianomusic';
            } else if (value == 1) {
              music = 'flute';
            } else if (value == 2) {
              music = 'guitar';
            } else {
              music = 'electric';
            }
            playMusic();
          });
        },
        children: [
          InkWell(
            onTap: () {
              startPiano(0);
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/pianoBG.jpeg'),
                    fit: BoxFit.cover,
                    opacity: .8),
              ),
              alignment: Alignment.center,
              child: SafeArea(
                child: Text(
                  'Piano',
                  style: TextStyle(
                      fontFamily: 'Musicografi',
                      color: Colors.black,
                      fontSize: 128,
                      backgroundColor: Colors.white.withOpacity(.1),
                      letterSpacing: 8),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              startPiano(1);
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/flute.jpg'),
                    fit: BoxFit.cover,
                    opacity: .8),
              ),
              alignment: Alignment.center,
              child: SafeArea(
                child: Text(
                  'Flute',
                  style: TextStyle(
                      fontFamily: 'Musicografi',
                      color: Colors.black,
                      fontSize: 128,
                      backgroundColor: Colors.white.withOpacity(.1),
                      letterSpacing: 8),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              startPiano(2);
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/guitar.jpg'),
                    fit: BoxFit.cover,
                    opacity: .8),
              ),
              alignment: Alignment.center,
              child: SafeArea(
                child: Text(
                  'Guitar',
                  style: TextStyle(
                      fontFamily: 'Musicografi',
                      color: Colors.black,
                      fontSize: 115,
                      backgroundColor: Colors.white.withOpacity(.1),
                      letterSpacing: 8),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              startPiano(3);
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/electric.jpg'),
                    fit: BoxFit.cover,
                    opacity: .8),
              ),
              alignment: Alignment.center,
              child: SafeArea(
                child: Text(
                  'Electric Guitar',
                  style: TextStyle(
                      fontFamily: 'Musicografi',
                      color: Colors.white,
                      fontSize: 80,
                      backgroundColor: Colors.white.withOpacity(.1),
                      letterSpacing: 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
