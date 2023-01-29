import 'package:flutter/foundation.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../local_database/hive_db_util.dart';

enum TtsState { playing, stopped, paused, continued }

class TextToSpeechAPI {
  TextToSpeechAPI._() : super();
  // text to spedch
  static final String defaultLanguage = HiveDB.getData("default-lang") != null
      ? HiveDB.getData("default-lang")!
      : "en-US";
  static TextToSpeech tts = TextToSpeech();

  static double volume = 1; // Range: 0-1
  static double rate = 1.0; // Range: 0-2
  static double pitch = 1.0; // Range: 0-2
  static String? language;
  static String? engine;
  static String? languageCode;
  static List<String> languages = <String>[];
  static List<String> languageCodes = <String>[];
  static String? voice;

  //text to speech
  static Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = TextToSpeechAPI.supportPause ? ['en-us']: await tts.getLanguages();
    
    print("language codes ... " + languageCodes.toString());

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages =TextToSpeechAPI.supportPause ? ['English (US)']:await tts.getDisplayLanguages();

    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await tts.getDefaultLanguage();
    print("default language code " + defaultLangCode.toString());

    if (defaultLanguage.isNotEmpty && languageCodes.contains(defaultLanguage)) {
      languageCode = defaultLanguage;
    } else {
      languageCode = defaultLangCode;
    }
    language = await tts.getDisplayLanguageByCode(languageCode!);
    HiveDB.addData("laguage", language.toString());

    /// get voice
    voice = await getVoiceByLang(languageCode!);
  }

  static Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(languageCode!);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  static bool get supportPause =>
      defaultTargetPlatform != TargetPlatform.android;

  static bool get supportResume =>
      defaultTargetPlatform != TargetPlatform.android;

  static Future<bool?> stope() async {
    return await tts.stop();
  }

  static Future<bool?> pause() async {
    var xy = await tts.pause();
    return xy;
  }

  static Future<bool?> resume() async {
    return await tts.resume();
  }

  static void speak(String text) {
    tts.setVolume(volume);
    tts.setRate(rate);
    if (languageCode != null) {

      tts.setLanguage(languageCode!);
    }
    tts.setPitch(pitch);
    tts.speak(text);
  }
}
