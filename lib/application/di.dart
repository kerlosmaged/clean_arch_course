import 'package:app/application/app_prefernces.dart';
import 'package:app/data/data_source/local_data_source.dart';
import 'package:app/data/data_source/remote_data_source.dart';
import 'package:app/data/network/app_api.dart';
import 'package:app/data/network/dio_factory.dart';
import 'package:app/data/network/network_info.dart';
import 'package:app/data/repository/repository_impl.dart';
import 'package:app/domain/repository/repository.dart';
import 'package:app/domain/usecase/forgetpassword_usecase.dart';
import 'package:app/domain/usecase/home_usecase.dart';
import 'package:app/domain/usecase/login_usecase.dart';
import 'package:app/domain/usecase/register_usecase.dart';
import 'package:app/domain/usecase/store_details_usecase.dart';
import 'package:app/presentation/forgetPassword/viewmodel/forgetpassword_view_model.dart';
import 'package:app/presentation/login/viewmodel/login_view_model.dart';
import 'package:app/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:app/presentation/register/viewModel/registre_viewmodel.dart';
import 'package:app/presentation/storeDetails/viewmodel/storedetails_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppMoudle() async {
  // app module , its a module where we put all generic dependencies

  // this is instance from SharedPrefernces package
  final sharepref = await SharedPreferences.getInstance();

  // here we add it in Getit map
  instance.registerLazySingleton<SharedPreferences>(() => sharepref);

  // this is instance from appPref class and we put the sharedPrefernces type for instance we need it
  instance.registerLazySingleton<AppPrefernces>(
    () => AppPrefernces(
      sharedPreferences: instance<SharedPreferences>(),
    ),
  );

  // network info

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  // dio factory

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(
      instance<AppPrefernces>(),
    ),
  );

  // app service client

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source

  instance.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      instance<AppServiceClient>(),
    ),
  );

  // local data source
  instance.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // repository

  instance.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      instance<NetworkInfo>(),
      instance<RemoteDataSource>(),
      instance<LocalDataSource>(),
    ),
  );
}

loginAppModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(
        instance<Repository>(),
      ),
    );
    instance.registerFactory<LoginViewModel>(
      () => LoginViewModel(
        instance<LoginUseCase>(),
      ),
    );
  }
}

forgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    // instance of forget pasword use case
    instance.registerFactory(
      () => ForgetPasswordUseCase(
        instance<Repository>(),
      ),
    );
    // instance of forget password view model
    instance.registerFactory(
      () => ForgetPasswordViewModel(
        instance<ForgetPasswordUseCase>(),
      ),
    );
  }
}

registerModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory(
      () => RegisterUseCase(
        instance<Repository>(),
      ),
    );
    instance.registerFactory(
      () => RegistreViewModel(
        instance<RegisterUseCase>(),
      ),
    );
    instance.registerLazySingleton<ImagePicker>(() => ImagePicker());
  }
}

homeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(
      () => HomeUseCase(
        repository: instance<Repository>(),
      ),
    );
    instance.registerFactory<HomeViewModel>(
      () => HomeViewModel(
        homeUseCase: instance<HomeUseCase>(),
      ),
    );
  }
}

storeDtailsModule() {
  if (!GetIt.I.isRegistered<StoreDetailsUseCase>()) {
    instance.registerFactory<StoreDetailsUseCase>(
      () => StoreDetailsUseCase(repository: instance<Repository>()),
    );
    instance.registerFactory<StoreDetailsViewModel>(
      () => StoreDetailsViewModel(
        storeDetailsUseCase: instance<StoreDetailsUseCase>(),
      ),
    );
  }
}
