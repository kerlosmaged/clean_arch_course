import 'dart:async';

import 'package:app/domain/usecase/login_usecase.dart';
import 'package:app/presentation/base/base_viewmodel.dart';
import 'package:app/presentation/comman/freezed.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  final _userNameStreamController = StreamController<String>.broadcast();

  final _passwordStreamController = StreamController<String>.broadcast();

  final _areAllInputValid = StreamController<void>.broadcast();

  final userIsLogedInSuccessfullyStreamController = StreamController<bool>();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  var _loginObject = LoginObject("", "");

  // this is section for input data

  @override
  void end() {
    super.end();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputValid.close();
    userIsLogedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // her we will tell the state renderer send the content state to base view model
    inputStateRender.add(ContentState());
  }

  @override
  setUserName({required String userName}) {
    inputUserName.add(userName);
    _loginObject = _loginObject.copyWith(userName: userName);
    inputAllOfInputValid.add(null);
  }

  @override
  setPassword({required String password}) {
    inputPassword.add(password);
    _loginObject = _loginObject.copyWith(password: password);
    inputAllOfInputValid.add(null);
  }

  @override
  login() async {
    // need to tell the state renderer loading when we start click on the loagin button
    inputStateRender.add(
      LoadingState(
        stateRendererTypes: StateRendererType.popupLoadingState,
      ),
    );
    (await _loginUseCase.execute(
      LoginUseCaseInput(
          email: _loginObject.userName, password: _loginObject.password),
    ))
        .fold((fauiler) {
      // left is failure

      inputStateRender.add(
        ErrorState(
            stateRendererTypes: StateRendererType.popupErrorState,
            errorMessage: fauiler.message),
      );
    }, (data) {
      // right is success
      // inputStateRender.add(SuccessState(message: null));
      userIsLogedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllOfInputValid => _areAllInputValid.sink;

  // this is section for output things

  @override
  Stream<bool> get outputPassword => _passwordStreamController.stream
      .map((password) => _checkPassword(password));

  @override
  Stream<bool> get outputEmail => _userNameStreamController.stream
      .map((userName) => _checkUserName(userName));

  @override
  Stream<bool> get outAllOfInputValid => _areAllInputValid.stream.map(
        (_) => _checkAllInputIsValid(),
      );

  // this is section for private function

  bool _checkPassword(String password) {
    return password.isNotEmpty ? true : false;
  }

  bool _checkUserName(String userName) {
    return userName.isNotEmpty ? true : false;
  }

  bool _checkAllInputIsValid() {
    return _checkPassword(_loginObject.password) &&
        _checkUserName(_loginObject.userName);
  }
}

abstract class LoginViewModelInput {
  setUserName({required String userName});
  setPassword({required String password});
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAllOfInputValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputEmail;
  Stream<bool> get outputPassword;
  Stream<bool> get outAllOfInputValid;
}
