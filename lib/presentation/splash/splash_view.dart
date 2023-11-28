import 'dart:async';

import 'package:app/application/app_constants.dart';
import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _sharedPref = instance<AppPrefernces>();
  Timer? _timer;
  _bind() {
    _timer = Timer(const Duration(seconds: AppConstant.durationTime), () {
      goNext();
    });
  }

  goNext() async {
    _sharedPref.isLoginViwed().then(
      (isLoginViwed) {
        if (isLoginViwed) {
          // here the user is show onBoarding screen and login success so will go to main screen
          Navigator.of(context).pushReplacementNamed(Routes.main);
        } else {
          _sharedPref.isOnBoardingViwed().then(
            (isOnBoardingViwed) {
              if (isOnBoardingViwed) {
                // here the user is show onBoarding screen but still don't login so will go to login screen
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              } else {
                // the user is new so don't see any thing so will go to on boarding
                Navigator.of(context)
                    .pushReplacementNamed(Routes.onBoardingRoute);
              }
            },
          );
        }
      },
    );
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppConstant.elevetionZero,
      ),
      backgroundColor: ColorManager.primaryColor,
      body: Center(child: Image.asset(ImagesAssetsPath.splashLogo)),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
