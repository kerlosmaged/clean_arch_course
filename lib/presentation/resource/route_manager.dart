import 'package:app/application/di.dart';
import 'package:app/presentation/forgetPassword/view/forgetpassword_view.dart';
import 'package:app/presentation/login/view/login_view.dart';
import 'package:app/presentation/main/main_view.dart';
import 'package:app/presentation/onBoarding/view/onboarding_view.dart';
import 'package:app/presentation/register/view/registre_view.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/splash/splash_view.dart';
import 'package:app/presentation/storeDetails/view/storedetails_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetRoute = "/forget";
  static const String main = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case Routes.loginRoute:
        loginAppModule();
        return MaterialPageRoute(builder: (context) => const LoginView());

      case Routes.registerRoute:
        registerModule();
        return MaterialPageRoute(builder: (context) => const RegisterView());

      case Routes.forgetRoute:
        forgetPasswordModule();
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordView());

      case Routes.main:
        homeModule();
        storeDtailsModule();
        return MaterialPageRoute(builder: (context) => const MainView());

      case Routes.storeDetailsRoute:
        storeDtailsModule();
        return MaterialPageRoute(
            builder: (context) => const StoreDetailsView());

      default:
        return MaterialPageRoute(builder: (context) => const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.noRouteFound,
        ).tr(),
      ),
      body: Center(
        child: const Text(
          AppStrings.noRouteFound,
        ).tr(),
      ),
    );
  }
}
