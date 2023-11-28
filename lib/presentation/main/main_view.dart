import 'package:app/application/app_constants.dart';
import 'package:app/presentation/main/pages/home/view/home_page.dart';
import 'package:app/presentation/main/pages/notifications/view/notifications_page.dart';
import 'package:app/presentation/main/pages/search/view/search_page.dart';
import 'package:app/presentation/main/pages/setting/view/settinges_page.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingesPage()
  ];

  List<String> titles = const [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  String _title = AppStrings.home;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title).tr(),
        elevation: AppConstant.elevetionZero,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey,
              spreadRadius: AppSizeManager.s1_5,
            )
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: _changeOnTap,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: AppStrings.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppStrings.notifications.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppStrings.settings.tr(),
            ),
          ],
        ),
      ),
    );
  }

  void _changeOnTap(newIndex) {
    setState(() {
      _currentIndex = newIndex;
      _title = titles[_currentIndex];
    });
  }
}
