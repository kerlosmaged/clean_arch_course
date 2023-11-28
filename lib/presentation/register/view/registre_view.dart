// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:app/application/app_constants.dart';
import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:app/presentation/register/viewModel/registre_viewmodel.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _imagePickerInstance = instance<ImagePicker>();
  final _registerViewModel = instance<RegistreViewModel>();
  final _sharedPref = instance<AppPrefernces>();

  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  _bind() {
    _registerViewModel.start();

    _userNameController.addListener(
      () => _registerViewModel.setUserName(name: _userNameController.text),
    );
    _emailController.addListener(
      () => _registerViewModel.setEmail(email: _emailController.text),
    );
    _passwordController.addListener(
      () => _registerViewModel.setPassword(password: _passwordController.text),
    );
    _phoneNumberController.addListener(
      () => _registerViewModel.setphoneNumber(
          phoneNumberUser: _phoneNumberController.text),
    );
    _registerViewModel.isUsedInSuccuss.stream.listen(
      (value) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) {
            if (value == true) {
              Navigator.of(context).pushNamed(Routes.main);
              _sharedPref.setLoginViwed();
            }
          },
        );
      },
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
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.primaryColor),
        elevation: AppConstant.elevetionZero,
      ),
      body: StreamBuilder<FlowState>(
        stream: _registerViewModel.outPutStateRender,
        builder: (context, snapshot) {
          return snapshot.data?.getContentScreen(
                context: context,
                currentContentScreen: _bodyRegister(),
                retryFunction: () {},
              ) ??
              _bodyRegister();
        },
      ),
    );
  }

  @override
  void dispose() {
    _registerViewModel.end();
    super.dispose();
  }

  Widget _bodyRegister() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Image.asset(ImagesAssetsPath.splashLogo),
            // userName
            StreamBuilderWidget(
              steram: _registerViewModel.userNameOutPut,
              controller: _userNameController,
              hintText: AppStrings.username.tr(),
              labelText: AppStrings.username.tr(),
              errorText: AppStrings.usernameError.tr(),
              obscureText: false,
            ),
            // mobile number
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CountryCodePicker(
                    initialSelection: "+20",
                    onInit: (newContryCode) {
                      _registerViewModel.setphoneCode(
                          phoneCodeUser:
                              newContryCode?.dialCode ?? AppConstant.token);
                    },
                    onChanged: (newContryCode) {
                      _registerViewModel.setphoneCode(
                          phoneCodeUser:
                              newContryCode.dialCode ?? AppConstant.token);
                    },
                    showCountryOnly: true,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: StreamBuilderWidget(
                    steram: _registerViewModel.phoneNumberOutPut,
                    controller: _phoneNumberController,
                    hintText: AppStrings.mobileNumber.tr(),
                    labelText: AppStrings.mobileNumber.tr(),
                    errorText: AppStrings.mobileNumberInvalid.tr(),
                    obscureText: false,
                    textInputType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            // email
            StreamBuilderWidget(
              steram: _registerViewModel.emailOutPut,
              controller: _emailController,
              hintText: AppStrings.emailHint.tr(),
              labelText: AppStrings.emailHint.tr(),
              errorText: AppStrings.invalidEmail.tr(),
              obscureText: false,
            ),
            //password
            StreamBuilderWidget(
              steram: _registerViewModel.passwordOutPut,
              controller: _passwordController,
              hintText: AppStrings.password.tr(),
              labelText: AppStrings.password.tr(),
              errorText: AppStrings.passwordError.tr(),
              obscureText: true,
              icon: const Icon(Icons.remove_red_eye_sharp),
            ),
            // image user
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddingManager.p18,
                vertical: AppPaddingManager.p8,
              ),
              child: Container(
                height: AppSizeManager.s45,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.lightGrey),
                  borderRadius: BorderRadius.circular(AppSizeManager.s12),
                ),
                child: GestureDetector(
                  child: _getGestureWidget(),
                  onTap: () {
                    _getImagePath(context);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: AppSizeManager.s8,
            ),
            // register button
            StreamBuilder(
              stream: _registerViewModel.checkAllDataOutPut,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SizedBox(
                    width: double.infinity,
                    // height: AppSizeManager.s28,
                    child: ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _registerViewModel.register();
                            }
                          : null,
                      child: const Text(
                        AppStrings.register,
                      ).tr(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getGestureWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPaddingManager.p12,
        right: AppPaddingManager.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: const Text(AppStrings.profilePicture).tr(),
          ),
          Flexible(
            child: StreamBuilder(
              stream: _registerViewModel.userImageOutPut,
              builder: (context, snapshot) {
                return _imagePickByUser(snapshot.data);
              },
            ),
          ),
          Flexible(
            child: SvgPicture.asset(
              ImagesAssetsPath.photoCameraIc,
            ),
          ),
        ],
      ),
    );
  }

  _imagePickByUser(File? file) {
    if (file != null && file.path.isNotEmpty) {
      return Image.file(file);
    } else {
      return Container();
    }
  }

  _getImagePath(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.browse_gallery),
                title: const Text(AppStrings.photoGallery).tr(),
                onTap: () {
                  _getImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoCamera).tr(),
                onTap: () {
                  _getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _getImageFromGallery() async {
    var file =
        await _imagePickerInstance.pickImage(source: ImageSource.gallery);
    _registerViewModel.setuserImage(image: File(file?.path ?? ""));
  }

  _getImageFromCamera() async {
    var file = await _imagePickerInstance.pickImage(source: ImageSource.camera);
    _registerViewModel.setuserImage(image: File(file?.path ?? ""));
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({
    super.key,
    required this.steram,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.errorText,
    this.obscureText,
    this.icon,
    this.textInputType,
  });

  final Stream<bool> steram;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String errorText;
  final Icon? icon;
  final bool? obscureText;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPaddingManager.p18, vertical: AppPaddingManager.p8),
      child: StreamBuilder<bool>(
        stream: steram,
        builder: (context, snapshot) {
          return TextFormField(
            obscureText: obscureText ?? false,
            keyboardType: textInputType,
            controller: controller,
            decoration: InputDecoration(
              suffixIconColor: ColorManager.darkGrey,
              suffixIcon: icon,
              hintText: hintText,
              labelText: labelText,
              errorText: (snapshot.data ?? true) ? null : errorText,
            ),
          );
        },
      ),
    );
  }
}
