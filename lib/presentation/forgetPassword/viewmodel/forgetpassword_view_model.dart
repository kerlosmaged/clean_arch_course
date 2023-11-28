import 'dart:async';

import 'package:app/domain/usecase/forgetpassword_usecase.dart';
import 'package:app/presentation/base/base_viewmodel.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    implements ForgetPasswordViewModelInput, ForgetPasswordViewModelOutput {
  final _userNameStreamController = StreamController<String>.broadcast();

  final _areAllInputValid = StreamController<void>.broadcast();

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  var email = "";

  // this is section for input data

  @override
  void end() {
    super.end();
    _userNameStreamController.close();
    _areAllInputValid.close();
  }

  @override
  void start() {
    // her we will tell the state renderer send the content state to base view model
    inputStateRender.add(ContentState());
  }

  @override
  setUserName({required String userName}) {
    inputUserName.add(userName);
    email = userName;
    inputAllOfInputValid.add(null);
  }

  @override
  forgetPassword() async {
    // need to tell the state renderer loading when we start click on the loagin button
    inputStateRender.add(
      LoadingState(
        stateRendererTypes: StateRendererType.popupLoadingState,
      ),
    );
    (await _forgetPasswordUseCase.execute(
      ForgetPasswordUseCaseInput(email: email),
    ))
        .fold(
      (fauiler) {
        // left is failure
        // print(
        //     "this is message from Error or Fauiler and this is message $fauiler");
        inputStateRender.add(
          ErrorState(
              stateRendererTypes: StateRendererType.popupErrorState,
              errorMessage: fauiler.message),
        );
      },
      (data) {
        // right is success
        inputStateRender.add(SuccessState(message: data.support));

        // print("this is message from data or success $data");
      },
    );
  }

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAllOfInputValid => _areAllInputValid.sink;

  // this is section for output things

  @override
  Stream<bool> get outputEmail => _userNameStreamController.stream
      .map((userName) => _checkUserName(userName));

  @override
  Stream<bool> get outAllOfInputValid => _areAllInputValid.stream.map(
        (_) => _checkAllInputIsValid(),
      );

  // this is section for private function

  bool _checkUserName(String userName) {
    // return isEmailValid(email: userName);
    return userName.isNotEmpty;
  }

  bool _checkAllInputIsValid() {
    return _checkUserName(email);
  }
}

abstract class ForgetPasswordViewModelInput {
  setUserName({required String userName});
  forgetPassword();

  Sink get inputUserName;
  Sink get inputAllOfInputValid;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get outputEmail;
  Stream<bool> get outAllOfInputValid;
}
