import 'dart:async';
import 'dart:io';

import 'package:app/domain/usecase/register_usecase.dart';
import 'package:app/presentation/base/base_viewmodel.dart';
import 'package:app/presentation/comman/freezed.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';

class RegistreViewModel extends BaseViewModel
    implements RegistreViewModelInput, RegistreViewModelOutput {
  final _userNameStreamController = StreamController<String>.broadcast();
  final _emailStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _phoneCodeStreamController = StreamController<String>.broadcast();
  final _phoneNumberStreamController = StreamController<String>.broadcast();
  final _userImageStreamController = StreamController<File>.broadcast();
  final _checkAllvalueStreamController = StreamController<void>.broadcast();
  final isUsedInSuccuss = StreamController<bool>();

  final RegisterUseCase _registerUseCase;

  RegistreViewModel(this._registerUseCase);

  // import from baseViewModel section
  @override
  void start() {
    inputStateRender.add(ContentState());
  }

  @override
  void end() {
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _phoneCodeStreamController.close();
    _phoneNumberStreamController.close();
    _userImageStreamController.close();
    _checkAllvalueStreamController.close();
    isUsedInSuccuss.close();
    super.end();
  }

  // data object section
  var _userData = RegisterObject(
    "",
    "",
    "",
    "",
    "",
    "",
  );

  // input section (Sink)
  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Sink get passwordInput => _passwordStreamController.sink;

  // @override
  // Sink get phoneCodeInput => _phoneCodeStreamController.sink;

  @override
  Sink get phoneNumberInput => _phoneNumberStreamController.sink;

  @override
  Sink get userImageInput => _userImageStreamController.sink;

  @override
  Sink get userNameInput => _userNameStreamController.sink;

  @override
  Sink get checkAllDataInput => _checkAllvalueStreamController.sink;

  @override
  Sink get phoneCodeInput => _phoneCodeStreamController.sink;
  // end input sink section

  // outPut Section (Stream)
  @override
  Stream<bool> get checkAllDataOutPut =>
      _checkAllvalueStreamController.stream.map(
        (_) => _ckeckAllUserData(),
      );

  @override
  Stream<bool> get emailOutPut => _emailStreamController.stream.map(
        (email) => _checkEmail(email: email),
      );

  @override
  Stream<bool> get passwordOutPut => _passwordStreamController.stream.map(
        (password) => _checkPassword(password: password),
      );

  @override
  Stream<bool> get phoneCodeOutPut => _phoneCodeStreamController.stream.map(
        (phoneCode) => _checkPhoneCode(phoneCode: phoneCode),
      );

  @override
  Stream<bool> get phoneNumberOutPut => _phoneNumberStreamController.stream.map(
        (phoneNumber) => _checkPhoneNumber(phoneNumber: phoneNumber),
      );

  @override
  Stream<File> get userImageOutPut => _userImageStreamController.stream.map(
        (userImage) => userImage,
      );

  @override
  Stream<bool> get userNameOutPut => _userNameStreamController.stream.map(
        (userName) => _checkUserName(userName: userName),
      );

  // end output stream section

  // user registeration
  @override
  register() async {
    inputStateRender.add(
      LoadingState(
        stateRendererTypes: StateRendererType.popupLoadingState,
      ),
    );
    (await _registerUseCase.execute(
      RegisterRequestUseCase(
        userName: _userData.username,
        email: _userData.email,
        password: _userData.passwrod,
        codeNumber: _userData.phoneCode,
        phoneNumber: _userData.phoneNumber,
        userImage: _userData.userImage,
      ),
    ))
        .fold(
      (left) {
        inputStateRender.add(
          ErrorState(
            stateRendererTypes: StateRendererType.popupErrorState,
            errorMessage: left.message,
          ),
        );
      },
      (right) {
        inputStateRender.add(
          SuccessState(),
        );
        isUsedInSuccuss.add(true);
      },
    );
  }

  // end user registeration section

  // set user input
  @override
  setEmail({required String email}) {
    emailInput.add(email);
    _userData = _userData.copyWith(email: email);
    validate();
  }

  @override
  setPassword({required String password}) {
    passwordInput.add(password);
    _userData = _userData.copyWith(passwrod: password);
    validate();
  }

  @override
  setUserName({required String name}) {
    userNameInput.add(name);
    _userData = _userData.copyWith(username: name);
    validate();
  }

  @override
  setphoneNumber({required String phoneNumberUser}) {
    phoneNumberInput.add(phoneNumberUser);
    _userData = _userData.copyWith(phoneNumber: phoneNumberUser);
    validate();
  }

  @override
  setuserImage({required File image}) {
    userImageInput.add(image);
    _userData = _userData.copyWith(userImage: image.path);
    validate();
  }

  @override
  setphoneCode({required String phoneCodeUser}) {
    phoneCodeInput.add(phoneCodeUser);
    _userData = _userData.copyWith(phoneCode: phoneCodeUser);
    validate();
  }

  // check validation section

  bool _checkUserName({required String userName}) {
    return userName.isNotEmpty;
  }

  bool _checkEmail({required String email}) {
    return email.isNotEmpty ? true : false;
  }

  bool _checkPassword({required String password}) {
    return password.length >= 7;
  }

  bool _checkPhoneNumber({required String phoneNumber}) {
    return phoneNumber.isNotEmpty;
  }

  bool _checkPhoneCode({required String phoneCode}) {
    return phoneCode.isNotEmpty;
  }

  bool _ckeckAllUserData() {
    return _userData.username.isNotEmpty &&
        _userData.email.isNotEmpty &&
        _userData.passwrod.isNotEmpty &&
        _userData.phoneNumber.isNotEmpty &&
        _userData.userImage.isNotEmpty;
  }

  validate() {
    checkAllDataInput.add(null);
  }
}

abstract class RegistreViewModelInput {
  setUserName({required String name});
  setEmail({required String email});
  setPassword({required String password});
  setphoneCode({required String phoneCodeUser});
  setphoneNumber({required String phoneNumberUser});
  setuserImage({required File image});
  register();

  Sink get userNameInput;
  Sink get emailInput;
  Sink get passwordInput;
  Sink get phoneCodeInput;
  Sink get phoneNumberInput;
  Sink get userImageInput;
  Sink get checkAllDataInput;
}

abstract class RegistreViewModelOutput {
  Stream<bool> get userNameOutPut;
  Stream<bool> get emailOutPut;
  Stream<bool> get passwordOutPut;
  Stream<bool> get phoneCodeOutPut;
  Stream<bool> get phoneNumberOutPut;
  Stream<File> get userImageOutPut;
  Stream<bool> get checkAllDataOutPut;
}
