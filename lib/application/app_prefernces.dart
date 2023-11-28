// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:app/presentation/resource/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferncesValues {
  static const String prefKeyLanguage = "PREFS_KEY_LANG";
  static const String prefKeyOnBoardingScreen = "PRE_KEY_ONBOARDING";
  static const String prefKeyLoginScreen = "PREFS_KEY_LOGIN";
}

class AppPrefernces {
  final SharedPreferences _sharedPreferences;
  AppPrefernces({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  Future<String> getAppLanguage() async {
    String? language =
        _sharedPreferences.getString(AppPreferncesValues.prefKeyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageTypes.english.getValueLanguage();
    }
  }

  Future<void> changeLanugage() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageTypes.arabic.getValueLanguage()) {
      // set english language
      _sharedPreferences.setString(AppPreferncesValues.prefKeyLanguage,
          LanguageTypes.english.getValueLanguage());
    } else {
      _sharedPreferences.setString(AppPreferncesValues.prefKeyLanguage,
          LanguageTypes.arabic.getValueLanguage());
    }
  }

  Future<Locale> getLocal() async {
    String language = await getAppLanguage();
    if (language == LanguageTypes.arabic.getValueLanguage()) {
      return ValueOfLanguages.localeArabic;
    } else {
      return ValueOfLanguages.localeEnglis; 
    }
  }

  //onboarding set , get
  Future<void> setOnBoardingViwed() async {
    _sharedPreferences.setBool(
        AppPreferncesValues.prefKeyOnBoardingScreen, true);
  }

  Future<bool> isOnBoardingViwed() async {
    return _sharedPreferences
            .getBool(AppPreferncesValues.prefKeyOnBoardingScreen) ??
        false;
  }

  // login set , get

  Future<void> setLoginViwed() async {
    _sharedPreferences.setBool(AppPreferncesValues.prefKeyLoginScreen, true);
  }

  Future<void> logOut() async {
    await _sharedPreferences.remove(AppPreferncesValues.prefKeyLoginScreen);
  }

  Future<bool> isLoginViwed() async {
    return _sharedPreferences.getBool(AppPreferncesValues.prefKeyLoginScreen) ??
        false;
  }
}
