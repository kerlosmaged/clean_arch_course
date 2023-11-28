import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:app/presentation/login/viewmodel/login_view_model.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _sharePref = instance<AppPrefernces>();

  _bind() {
    _loginViewModel.start();
    _emailController.addListener(
      () => _loginViewModel.setUserName(userName: _emailController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(password: _passwordController.text),
    );
    _loginViewModel.userIsLogedInSuccessfullyStreamController.stream
        .listen((isLoginTrue) {
      if (isLoginTrue) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _sharePref.setLoginViwed();
          Navigator.of(context).pushReplacementNamed(Routes.main);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outPutStateRender,
        builder: (context, snapshot) {
          return snapshot.data?.getContentScreen(
                  context: context,
                  currentContentScreen: _getContentScreen(),
                  retryFunction: () {}) ??
              _getContentScreen();
        },
      ),
    );
  }

  Widget _getContentScreen() {
    return Container(
      padding: const EdgeInsets.only(top: AppPaddingManager.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(ImagesAssetsPath.splashLogo),
              // email input
              const SizedBox(
                height: AppSizeManager.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPaddingManager.p28, right: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username.tr(),
                        labelText: AppStrings.username.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.usernameError.tr(),
                      ),
                    );
                  },
                ),
              ),
              // password input
              const SizedBox(
                height: AppSizeManager.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPaddingManager.p28, right: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  stream: _loginViewModel.outputPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password.tr(),
                        labelText: AppStrings.password.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError.tr(),
                      ),
                    );
                  },
                ),
              ),
              // login button
              const SizedBox(
                height: AppSizeManager.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPaddingManager.p28, right: AppPaddingManager.p28),
                child: StreamBuilder<bool>(
                  stream: _loginViewModel.outAllOfInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizeManager.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _loginViewModel.login();
                              }
                            : null,
                        child: const Text(AppStrings.login).tr(),
                      ),
                    );
                  },
                ),
              ),
              // forget button and regestire button
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPaddingManager.p28,
                    left: AppPaddingManager.p28,
                    right: AppPaddingManager.p28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.forgetRoute);
                      },
                      child: const Text(AppStrings.forgetPassword).tr(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.registerRoute);
                      },
                      child: const Text(AppStrings.register).tr(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this is section for close the view model
  @override
  void dispose() {
    _loginViewModel.end();
    super.dispose();
  }
}
