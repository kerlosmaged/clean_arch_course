import 'package:app/application/di.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:app/presentation/forgetPassword/viewmodel/forgetpassword_view_model.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordViewModel _forgetPasswordViewModel =
      instance<ForgetPasswordViewModel>();

  final GlobalKey _form = GlobalKey();

  _bind() {
    _forgetPasswordViewModel.start();
    _emailController.addListener(
      () =>
          _forgetPasswordViewModel.setUserName(userName: _emailController.text),
    );
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.primaryColor),
        centerTitle: false,
        elevation: 0,
        backgroundColor: ColorManager.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _forgetPasswordViewModel.outPutStateRender,
        builder: (context, snapshot) {
          return snapshot.data?.getContentScreen(
                context: context,
                currentContentScreen: _getContentScreen(),
                retryFunction: () {},
              ) ??
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
          key: _form,
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
                  stream: _forgetPasswordViewModel.outputEmail,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.emailHint.tr(),
                        labelText: AppStrings.emailHint.tr(),
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.invalidEmail.tr(),
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
                  stream: _forgetPasswordViewModel.outAllOfInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSizeManager.s40,
                      child: ElevatedButton(
                        onPressed: (snapshot.data ?? false)
                            ? () {
                                _forgetPasswordViewModel.forgetPassword();
                              }
                            : null,
                        child: const Text(AppStrings.resetPassword).tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _forgetPasswordViewModel.end();
    super.dispose();
  }
}
