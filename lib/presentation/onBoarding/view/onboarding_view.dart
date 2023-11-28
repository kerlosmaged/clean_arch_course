import 'package:app/application/app_constants.dart';
import 'package:app/application/app_prefernces.dart';
import 'package:app/application/di.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/presentation/onBoarding/viewmodel/onboarding_viewmodel.dart';
import 'package:app/presentation/resource/assetes_manager.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final _sharePref = instance<AppPrefernces>();

  _bind() {
    _viewModel.start();
    _sharePref.setOnBoardingViwed();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          elevation: AppSizeManager.s0,
          backgroundColor: ColorManager.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: _controller,
          itemCount: sliderViewObject.numberOfSlides,
          onPageChanged: (newIndex) {
            _viewModel.onPageChanged(newIndex);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(
              sliderObject: sliderViewObject.sliderObject,
            );
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute);
                  },
                  child: const Text(AppStrings.skip).tr(),
                ),
              ),
              // widget indecator and arrow
              const SizedBox(
                height: AppSizeManager.s12,
              ),
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left Arrow
          Padding(
            padding: const EdgeInsets.all(
              AppPaddingManager.p14,
            ),
            child: GestureDetector(
              onTap: () {
                _controller.animateToPage(
                  _viewModel.goPrevious(),
                  duration: const Duration(
                      milliseconds: AppConstant.slidearAnimation),
                  curve: Curves.bounceInOut,
                );
              },
              child: SvgPicture.asset(ImagesAssetsPath.leftArrow),
            ),
          ),
          // circle indecator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
                Padding(
                    padding: const EdgeInsets.all(AppPaddingManager.p8),
                    child: _getCirculIndecator(
                        index: i, currentIndex: sliderViewObject.currentIndex)),
            ],
          ),
          // right Arrow
          Padding(
            padding: const EdgeInsets.all(
              AppPaddingManager.p14,
            ),
            child: GestureDetector(
              onTap: () {
                _controller.animateToPage(
                  _viewModel.goNext(),
                  duration: const Duration(
                      milliseconds: AppConstant.slidearAnimation),
                  curve: Curves.bounceInOut,
                );
              },
              child: SvgPicture.asset(ImagesAssetsPath.rightArrow),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCirculIndecator({required int index, required int currentIndex}) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImagesAssetsPath.solid);
    } else {
      return SvgPicture.asset(ImagesAssetsPath.hollow);
    }
  }

  @override
  void dispose() {
    _viewModel.end();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingPage({
    super.key,
    required this.sliderObject,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSizeManager.s20,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddingManager.p8),
            child: Text(
              sliderObject.title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddingManager.p8),
            child: Text(
              sliderObject.subTitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: AppSizeManager.s40,
          ),
          SvgPicture.asset(sliderObject.imagePath),
        ],
      ),
    );
  }
}
