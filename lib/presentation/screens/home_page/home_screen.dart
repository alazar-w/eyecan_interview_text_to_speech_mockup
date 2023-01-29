import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_mockup/data/data.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:sizer/sizer.dart';
import 'package:text_to_speech/text_to_speech.dart';
import '../../../business/business.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class HomeScreen extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;
  const HomeScreen({super.key, required this.items});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeStyle _themeStyle;
  int _selectedTab = 0;
  // pdf reader
  PDFDoc? _pdfDoc;
  String _text = "";

  bool _buttonsEnabled = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TextToSpeechAPI.initLanguages();
    });
  }

  @override
  Widget build(BuildContext context) {
    _themeStyle = context.watch<CurrentThemeBloc>().state;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          drawer: Drawer(
            // width: 50.w,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: _themeStyle.evenDarkColor,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      LocalStrings.localString(
                          string: "welcome", context: context),
                      style: TextStyle(
                        color: _themeStyle.primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxFontSize: 35.sp.floorToDouble(),
                      minFontSize: 20.sp.floorToDouble(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.w),
                  child: _drawerItems(),
                )
              ],
            ),
          ),

          /// Define the persistent bottom bar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedTab,
            elevation: 12.0,
            onTap: (index) {
              if (index == 0) {
                TextToSpeechAPI.speak(
                    "Picking a new PDF document.... wait for it to load...");
                _pickPDFText();
              }
              if (index == 1) {
                _buttonsEnabled ? _readRandomPage() : () {};
              }
              if (index == 2) {
                _buttonsEnabled ? _readWholeDoc() : () {};
              }
              setState(() {
                _selectedTab = index;
              });
            },
            items: widget.items
                .map((item) => BottomNavigationBarItem(
                    icon: Icon(item.icon), label: item.title))
                .toList(),
          ),
          body: Container(
            color: _themeStyle.evenDarkColor,
            alignment: Alignment.center,
            padding: TargetPlatform.iOS == defaultTargetPlatform
                ? EdgeInsets.symmetric(vertical: 15.h)
                : EdgeInsets.symmetric(vertical: 12.h),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: TextToSpeechAPI.supportPause ? 35.w : 70.w,
                      height: 10.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          if (_text.isNotEmpty) {
                            TextToSpeechAPI.speak(_text);
                          } else {
                            // if (_buttonsEnabled) {
                            //   TextToSpeechAPI.speak(_text);
                            // }
                            nothingToRead("READ");
                          }
                        },
                        child: const Text(
                          "READ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextToSpeechAPI.supportPause
                        ? SizedBox(
                            width: 2.w,
                          )
                        : SizedBox(
                            width: 0.w,
                          ),
                    TextToSpeechAPI.supportPause
                        ? SizedBox(
                            width: 35.w,
                            height: 10.h,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: Colors.blueAccent),
                              onPressed: () {
                                if (_text.isEmpty) {
                                  nothingToRead("PAUSE");
                                }
                                TextToSpeechAPI.pause();
                              },
                              child: const Text(
                                "PAUSE",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 0.w,
                          ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: TextToSpeechAPI.supportPause ? 35.w : 70.w,
                      height: 10.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          if (_text.isEmpty) {
                            nothingToRead("STOP");
                          }
                          TextToSpeechAPI.stope();
                        },
                        child: const Text(
                          "STOP",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextToSpeechAPI.supportPause
                        ? SizedBox(
                            width: 2.w,
                          )
                        : SizedBox(
                            width: 0.w,
                          ),
                    TextToSpeechAPI.supportResume
                        ? SizedBox(
                            width: 35.w,
                            height: 10.h,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: Colors.blueAccent),
                              onPressed: () {
                                if (_text.isEmpty) {
                                  nothingToRead("RESUME");
                                }
                                TextToSpeechAPI.resume();
                              },
                              child: const Text(
                                "RESUME",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 0.w,
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    _pdfDoc == null
                        ? "Pick a new PDF document and wait for it to load..."
                        : "PDF document loaded, ${_pdfDoc!.length} pages\n",
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          _text,
                          style: TextStyle(
                              fontSize: 18, color: _themeStyle.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _drawerItems() {
    return Column(
      children: [
        Row(
          children: <Widget>[
            ReusableWidgets.autoSizeText(_themeStyle, context, "language"),
            SizedBox(
              width: 2.w,
            ),
            DropdownButton<String>(
              value: TextToSpeechAPI.language,
              icon: InkWell(
                  onTap: () {
                    setState(() {
                      TextToSpeechAPI.initLanguages();
                    });
                  },
                  child: const Icon(Icons.arrow_downward)),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: _themeStyle.evenDarkColor),
              onChanged: (String? newValue) async {
                var languageCode =
                    await TextToSpeech().getLanguageCodeByName(newValue!);
                TextToSpeechAPI.languageCode = languageCode;
                HiveDB.addData("default-lang", languageCode.toString());

                TextToSpeechAPI.voice = await TextToSpeechAPI.getVoiceByLang(
                    TextToSpeechAPI.languageCode!);
                setState(() {
                  TextToSpeechAPI.language = newValue;
                });
              },
              items: TextToSpeechAPI.languages
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: <Widget>[
            ReusableWidgets.autoSizeText(_themeStyle, context, "volume"),
            Expanded(
              child: Slider(
                value: TextToSpeechAPI.volume,
                min: 0,
                max: 2,
                label: TextToSpeechAPI.volume.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    TextToSpeechAPI.volume = value;
                  });
                },
              ),
            ),
            Text('(${TextToSpeechAPI.volume.toStringAsFixed(2)})'),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: <Widget>[
            ReusableWidgets.autoSizeText(_themeStyle, context, "rate"),
            Expanded(
              child: Slider(
                value: TextToSpeechAPI.rate,
                min: 0,
                max: 2,
                label: TextToSpeechAPI.rate.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    TextToSpeechAPI.rate = value;
                  });
                },
              ),
            ),
            Text('(${TextToSpeechAPI.rate.toStringAsFixed(2)})'),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: <Widget>[
            ReusableWidgets.autoSizeText(_themeStyle, context, "pitch"),
            Expanded(
              child: Slider(
                value: TextToSpeechAPI.pitch,
                min: 0,
                max: 2,
                label: TextToSpeechAPI.pitch.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    TextToSpeechAPI.pitch = value;
                  });
                },
              ),
            ),
            Text('(${TextToSpeechAPI.pitch.toStringAsFixed(2)})'),
          ],
        ),
      ],
    );
  }

  /// Picks a new PDF document from the device
  Future _pickPDFText() async {
    var filePickerResult = await FilePicker.platform.pickFiles();
    if (filePickerResult != null) {
      _pdfDoc = await PDFDoc.fromPath(filePickerResult.files.single.path!);
      if (_pdfDoc != null) {
        TextToSpeechAPI.speak("pdf loaded click read to start reading");
      }
      setState(() {});
    }
  }

  /// Reads a random page of the document
  Future _readRandomPage() async {
    if (_pdfDoc == null) {
      nothingToRead("read sample");
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text =
        await _pdfDoc!.pageAt(Random().nextInt(_pdfDoc!.length) + 1).text;
    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
    if (_text.isNotEmpty) {
      TextToSpeechAPI.speak(_text);
    }
  }

  /// Reads the whole document
  Future _readWholeDoc() async {
    if (_pdfDoc == null) {
      nothingToRead("read all page");
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc!.text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
    if (_text.isNotEmpty) {
      TextToSpeechAPI.speak(_text);
    }
  }

  void nothingToRead(String button) {
    // speak(
    //     "पढाए हिंदी रहारुप अनुवाद নমস্কার নমস্কার নমস্কার নমস্কার নমস্কার নমস্কার ");
    TextToSpeechAPI.speak(
        "$button clicked, No pdf document found please open a new pdf document first then i will read it to you!");
  }
  //text to speech
}
