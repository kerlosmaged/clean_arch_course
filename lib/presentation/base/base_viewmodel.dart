// we make this class abstract becuase this is classe will be inherated in the future
import 'dart:async';

import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  // shared variables and function that will be used in any place in the project or in the app
  final _streamControllerStateFlow = BehaviorSubject<FlowState>();

  @override
  void end() {
    _streamControllerStateFlow.close();
  }

  @override
  Sink get inputStateRender => _streamControllerStateFlow.sink;

  @override
  Stream<FlowState> get outPutStateRender =>
      _streamControllerStateFlow.stream.map((state) => state);
}

abstract class BaseViewModelInput {
  void start();

  void end();

  Sink get inputStateRender;
}

mixin BaseViewModelOutput {
  Stream<FlowState> get outPutStateRender;
}
