import 'package:app/application/di.dart';
import 'package:app/domain/model/models.dart';
import 'package:app/domain/usecase/home_usecase.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:app/presentation/resource/color_manager.dart';
import 'package:app/presentation/resource/route_manager.dart';
import 'package:app/presentation/resource/string_manager.dart';
import 'package:app/presentation/resource/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel(homeUseCase: instance<HomeUseCase>());
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outPutStateRender,
        builder: (context, snapshot) {
          return snapshot.data?.getContentScreen(
                context: context,
                currentContentScreen: _currentContentScreen(),
                retryFunction: () {
                  _viewModel.start();
                },
              ) ??
              _currentContentScreen();
        },
      ),
    );
  }

  Widget _currentContentScreen() {
    return StreamBuilder<HomeDataObject>(
        stream: _viewModel.allDataOutput,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: AppSizeManager.s14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bannerUI(snapshot.data?.bannerAdData),
                _getSection(AppStrings.services.tr()),
                _servicesUI(snapshot.data?.servicesData),
                _getSection(AppStrings.stores.tr()),
                _storesUi(snapshot.data?.storesData),
              ],
            ),
          );
        });
  }

  Widget _bannerUI(List<BannerAd>? dataBody) {
    if (dataBody == null) {
      return Container();
    } else {
      return CarouselSlider(
        items: dataBody
            .map(
              (bannerItem) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSizeManager.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSizeManager.s4,
                    ),
                    side: BorderSide(
                      color: ColorManager.primaryColor,
                      width: AppSizeManager.s1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizeManager.s12),
                    child: Image.network(
                      bannerItem.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSizeManager.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPaddingManager.p8,
        top: AppPaddingManager.p12,
        right: AppPaddingManager.p12,
        bottom: AppPaddingManager.p8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineLarge,
      ).tr(),
    );
  }

  _servicesUI(List<Services>? dataBody) {
    if (dataBody == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPaddingManager.p12,
          right: AppPaddingManager.p12,
        ),
        child: Container(
          height: AppSizeManager.s180,
          margin: const EdgeInsets.symmetric(vertical: AppMarginManager.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: dataBody
                .map(
                  (itemServices) => SizedBox(
                    child: Card(
                      elevation: AppSizeManager.s4,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppSizeManager.s12),
                            child: Image.network(
                              itemServices.image,
                              fit: BoxFit.cover,
                              height: AppSizeManager.s120,
                              width: AppSizeManager.s120,
                            ),
                          ),
                          const SizedBox(
                            height: AppSizeManager.s6,
                          ),
                          Text(itemServices.title).tr(),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }

  _storesUi(List<Stores>? data) {
    if (data == null) {
      return Container();
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPaddingManager.p12,
          right: AppPaddingManager.p12,
          top: AppPaddingManager.p8,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSizeManager.s2.toInt(),
              crossAxisSpacing: AppSizeManager.s8,
              mainAxisSpacing: AppSizeManager.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                data.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      // navigate to store detailes
                      Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                    },
                    child: Card(
                      child: Image.network(
                        data[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.end();
    super.dispose();
  }
}
