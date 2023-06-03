import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';
import 'package:piano_app_gsg/mainScreen.dart';

class piano extends StatefulWidget {
  int pianoType;
  piano(this.pianoType, {Key? key}) : super(key: key);

  @override
  State<piano> createState() => _pianoState();
}

class _pianoState extends State<piano> {
  Future deviceDirection() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  FlutterMidi flutterMidi = FlutterMidi();
  @override
  void initState() {
    super.initState();
    deviceDirection();
  }

  void load(String asset) async {
    flutterMidi.unmute();
    ByteData _byte = await rootBundle.load(asset);
    flutterMidi.prepare(sf2: _byte);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pianoType == 0) {
      load('assets/midi/piano.sf2');
    } else if (widget.pianoType == 1) {
      load('assets/midi/flute.sf2');
    } else if (widget.pianoType == 2) {
      load('assets/midi/guitars.sf2');
    } else {
      load('assets/midi/electric.sf2');
    }
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => mainScreen()));
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: InteractivePiano(
              highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
              naturalColor: Colors.white,
              accidentalColor: Colors.black,
              keyWidth: 60,
              noteRange: NoteRange.forClefs([
                Clef.Treble,
              ]),
              onNotePositionTapped: (position) {
                flutterMidi.playMidiNote(midi: position.pitch);
              },
            ),
          )),
    );
  }
}
