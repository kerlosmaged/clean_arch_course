import 'dart:ffi';

import 'package:app/presentation/comman/state_renderer/state_renderer.dart';
import 'package:app/presentation/comman/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app/domain/usecase/store_details_usecase.dart';
import 'package:app/presentation/base/base_viewmodel.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _streamController = BehaviorSubject<StoreDetailsObject>();
  final StoreDetailsUseCase storeDetailsUseCase;
  StoreDetailsViewModel({required this.storeDetailsUseCase});

  @override
  void start() {
    _getStoreDetailsData();
  }

  _getStoreDetailsData() async {
    inputStateRender.add(
      LoadingState(
          stateRendererTypes: StateRendererType.fullScreenLoadingState),
    );
    // ignore: void_checks
    (await storeDetailsUseCase.execute(Void)).fold(
      (fail) {
        inputStateRender.add(
          ErrorState(
            stateRendererTypes: StateRendererType.fullScreenErrorState,
            errorMessage: fail.message,
          ),
        );
      },
      (data) {
        inputStateRender.add(ContentState());
        storedetailsInput.add(
          StoreDetailsObject(
            image: data.image,
            details: data.details,
            services: data.services,
            about: data.about,
          ),
        );
      },
    );
  }

  @override
  void end() {
    _streamController.close();
    super.end();
  }

  @override
  Sink<StoreDetailsObject> get storedetailsInput => _streamController.sink;

  @override
  Stream<StoreDetailsObject> get storedetailsOutput =>
      _streamController.stream.map((storeDetailsItem) => storeDetailsItem);
}

abstract class StoreDetailsViewModelInput {
  Sink<StoreDetailsObject> get storedetailsInput;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetailsObject> get storedetailsOutput;
}

class StoreDetailsObject {
  String image;
  String details;
  String services;
  String about;
  StoreDetailsObject({
    required this.image,
    required this.details,
    required this.services,
    required this.about,
  });
}
