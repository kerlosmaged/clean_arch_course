import 'package:app/application/di.dart';
import 'package:app/application/my_app.dart';
import 'package:app/presentation/resource/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppMoudle();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        ValueOfLanguages.localeEnglis,
        ValueOfLanguages.localeArabic
      ],
      path: ValueOfLanguages.translationPath,
      child: Phoenix(child: MyApp()),
    ),
  );
}
