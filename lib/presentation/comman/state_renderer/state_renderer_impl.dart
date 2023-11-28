// ignore_for_file: public_member_api_docs, sort_constructors_first
// this is file for connect with view and stateRenderer implementation (UI for state renderer)

import 'package:app/application/app_constants.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// this is class for two types of loading (popup , full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererTypes;
  String loadingMessge;

  LoadingState({
    required this.stateRendererTypes,
    this.loadingMessge = AppStrings.loading,
  });

  @override
  StateRendererType getStateRendererType() => stateRendererTypes;

  @override
  String getMessage() => loadingMessge;
}

// this is class for two types of error (popup , full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererTypes;
  String errorMessage;

  ErrorState({
    required this.stateRendererTypes,
    required this.errorMessage,
  });

  @override
  String getMessage() => errorMessage;

  @override
  StateRendererType getStateRendererType() => stateRendererTypes;
}

// this is class for full screen empty state
class EmptyState extends FlowState {
  String emptyMessage;
  EmptyState({required this.emptyMessage});

  @override
  String getMessage() => AppConstant.emptyString;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

// this is class for content state

class ContentState extends FlowState {
  @override
  String getMessage() => AppConstant.emptyString;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class SuccessState extends FlowState {
  final String? message;

  SuccessState({this.message});

  @override
  String getMessage() => message ?? AppConstant.emptyString;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

extension FlowStateExtesnion on FlowState {
  Widget getContentScreen({
    required BuildContext context,
    required Widget currentContentScreen,
    required Function retryFunction,
  }) {
    switch (runtimeType) {
      case const (LoadingState):
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            getDialogPopup(
              context: context,
              message: getMessage(),
              stateRendererTypes: getStateRendererType(),
            );
            return currentContentScreen;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryFunction,
              message: getMessage(),
            );
          }
        }

      case const (ErrorState):
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            getDialogPopup(
              context: context,
              message: getMessage(),
              stateRendererTypes: getStateRendererType(),
            );
            return currentContentScreen;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryFunction,
              message: getMessage(),
            );
          }
        }

      case const (EmptyState):
        {
          // dismissDialog(context);
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryFunction,
            message: getMessage(),
          );
        }

      case const (ContentState):
        {
          // dismissDialog(context);
          return currentContentScreen;
        }

      case const (SuccessState):
        {
          dismissDialog(context);
          getDialogPopup(
            stateRendererTypes: StateRendererType.popupSuccess,
            message: getMessage(),
            context: context,
          );
          return currentContentScreen;
        }

      default:
        {
          return currentContentScreen;
        }
    }
  }
}

_isCurrentstateIsOpend(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;

dismissDialog(BuildContext context) {
  if (_isCurrentstateIsOpend(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

// this is function for handling between loading and error popup states
getDialogPopup({
  required String message,
  required BuildContext context,
  required StateRendererType stateRendererTypes,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      builder: (BuildContext context) => StateRenderer(
        // this is state renderer type we will entered top in switch cases
        stateRendererType: stateRendererTypes,
        // this is function for the button in error case but we don't need it because we don't make thing in error
        retryActionFunction: () {},
        // this is message will send for state renderer ui and will show in this class but need it her because this is class will used in view
        message: message,
      ),
      context: context,
    );
  });
}
