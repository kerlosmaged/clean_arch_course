import 'dart:ui';

enum LanguageTypes {
  english,
  arabic,
}

class ValueOfLanguages {
  static const String english = "en";
  static const String arabic = "ar";
  static const String translationPath = r"assets/translation";
  static const Locale localeEnglis = Locale("en", "US");
  static const Locale localeArabic = Locale("ar", "SA");
}

extension LanguageTypesExtension on LanguageTypes {
  String getValueLanguage() {
    switch (this) {
      case LanguageTypes.english:
        return ValueOfLanguages.english;
      case LanguageTypes.arabic:
        return ValueOfLanguages.arabic;
    }
  }
}
