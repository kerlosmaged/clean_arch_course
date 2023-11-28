import 'dart:async';
import 'dart:ffi';

import 'package:app/domain/model/models.dart';
import 'package:app/domain/usecase/home_usecase.dart';
import 'package:app/presentation/base/base_viewmodel.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInput, HomViewModelOutput {
  final _listOfAllData = BehaviorSubject<HomeDataObject>();

  final HomeUseCase homeUseCase;
  HomeViewModel({required this.homeUseCase});

  @override
  void start() {
    _getData();
  }

  _getData() async {
    inputStateRender.add(
      LoadingState(
        stateRendererTypes: StateRendererType.fullScreenLoadingState,
      ),
    );
    // ignore: void_checks
    (await homeUseCase.execute(Void)).fold(
      (fail) {
        inputStateRender.add(
          ErrorState(
            stateRendererTypes: StateRendererType.fullScreenErrorState,
            errorMessage: fail.message,
          ),
        );
      },
      (allOfData) {
        allDataInput.add(
          HomeDataObject(
            bannerAdData: allOfData.data.banner,
            servicesData: allOfData.data.services,
            storesData: allOfData.data.stores,
          ),
        );
        inputStateRender.add(ContentState());
      },
    );
  }

  @override
  void end() {
    _listOfAllData.close();

    super.end();
  }

  // sink start work

  @override
  Sink get allDataInput => _listOfAllData.sink;

  // sink end work

  // stream start work

  @override
  Stream<HomeDataObject> get allDataOutput => _listOfAllData.stream.map(
        (servicesItem) => servicesItem,
      );

  // stream end work
}

abstract class HomeViewModelInput {
  Sink get allDataInput;
}

abstract class HomViewModelOutput {
  Stream<HomeDataObject> get allDataOutput;
}

class HomeDataObject {
  List<BannerAd>? bannerAdData;
  List<Services>? servicesData;
  List<Stores>? storesData;
  HomeDataObject({
    required this.bannerAdData,
    required this.servicesData,
    required this.storesData,
  });
}
