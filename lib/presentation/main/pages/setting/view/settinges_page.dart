import 'dart:math';

import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/data/data_source/local_data_source.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/language_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';

class SettingesPage extends StatefulWidget {
  const SettingesPage({super.key});

  @override
  State<SettingesPage> createState() => _SettingesPageState();
}

class _SettingesPageState extends State<SettingesPage> {
  final AppPrefernces appPrefernces = instance<AppPrefernces>();
  final LocalDataSource localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPaddingManager.p8),
      children: [
        // change lang
        ListTile(
          leading: SvgPicture.asset(ImagesAssetsPath.changeLangIc),
          title: Text(
            AppStrings.changeLanguage.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          onTap: () {
            _changeLanguage();
          },
          trailing: Transform(
            transform: Matrix4.rotationY(_rotatArrow() ? pi : 0),
            child: SvgPicture.asset(ImagesAssetsPath.rightArrowSettingsIc),
          ),
        ),
        // contact Us
        ListTileSettings(
          imageLeading: ImagesAssetsPath.contactUsIc,
          ontTap: () {},
          title: AppStrings.contactUs.tr(),
          langValue: _rotatArrow(),
        ),
        // invite Your friends
        ListTileSettings(
          imageLeading: ImagesAssetsPath.inviteFriendsIc,
          ontTap: () {},
          title: AppStrings.inviteYourFriends.tr(),
          langValue: _rotatArrow(),
        ),
        ListTile(
          leading: SvgPicture.asset(ImagesAssetsPath.logOut),
          title: Text(
            AppStrings.logout.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          onTap: () => _logOut(),
          trailing: Transform(
            transform: Matrix4.rotationY(_rotatArrow() ? pi : 0),
            child: SvgPicture.asset(ImagesAssetsPath.rightArrowSettingsIc),
          ),
        )
      ],
    );
  }

  _changeLanguage() {
    appPrefernces.changeLanugage();
    Phoenix.rebirth(context);
  }

  bool _rotatArrow() {
    return context.locale == ValueOfLanguages.localeArabic;
  }

  _logOut() {
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
    appPrefernces.logOut();
    localDataSource.clearCache();
  }
}

class ListTileSettings extends StatelessWidget {
  final String imageLeading;
  final String title;
  final Function ontTap;
  final bool langValue;
  const ListTileSettings({
    super.key,
    required this.imageLeading,
    required this.title,
    required this.ontTap,
    required this.langValue,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(imageLeading),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      trailing: Transform(
        transform: Matrix4.rotationY(langValue ? pi : 0),
        child: SvgPicture.asset(ImagesAssetsPath.rightArrowSettingsIc),
      ),
      onTap: ontTap(),
    );
  }
}
