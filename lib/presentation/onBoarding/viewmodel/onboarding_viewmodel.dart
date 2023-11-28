// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:app/domain/model/models.dart';
import 'package:app/presentation/base/base_viewmodel.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
  final BehaviorSubject<SliderViewObject> _streamController =
      BehaviorSubject<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void end() {
    // end the stream controller or view model job
    _streamController.close();
  }

  @override
  void start() {
    // view model start job
    _list = _getDataList();
    _sendDataToView();
  }
  // onboarding private functions

  List<SliderObject> _getDataList() => [
        SliderObject(
          title: AppStrings.onBoardingSubTitle1.tr(),
          subTitle: AppStrings.onBoardingSubTitle1.tr(),
          imagePath: ImagesAssetsPath.onBoardingLogo1,
        ),
        SliderObject(
          title: AppStrings.onBoardingSubTitle2.tr(),
          subTitle: AppStrings.onBoardingSubTitle2.tr(),
          imagePath: ImagesAssetsPath.onBoardingLogo2,
        ),
        SliderObject(
          title: AppStrings.onBoardingSubTitle3.tr(),
          subTitle: AppStrings.onBoardingSubTitle3.tr(),
          imagePath: ImagesAssetsPath.onBoardingLogo3,
        ),
        SliderObject(
          title: AppStrings.onBoardingSubTitle4.tr(),
          subTitle: AppStrings.onBoardingSubTitle4.tr(),
          imagePath: ImagesAssetsPath.onBoardingLogo4,
        ),
      ];

  _sendDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(
          sliderObject: _list[_currentIndex],
          numberOfSlides: _list.length,
          currentIndex: _currentIndex),
    );
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _sendDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);
}

mixin OnBoardingViewModelInput {
  int goNext();
  int goPrevious();
  void onPageChanged(int index);
  // stream controller input
  Sink get inputSliderViewObject;
}

mixin OnBoardingViewModelOutput {
  Stream<SliderViewObject> get outputSliderViewObject;
}
