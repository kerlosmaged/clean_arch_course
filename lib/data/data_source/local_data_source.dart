// this is file for local data on the application or for the cache data

import 'package:app/data/network/error_handler.dart';
import 'package:app/data/response/responses.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHomeDataCached();
  Future<void> saveHomeDataToCache(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getDetailsDataCached();
  Future<void> saveDetailsDataToCache(
      StoreDetailsResponse storeDetailsResponse);

  void clearCache();
  void removeDataFromCache(String key);
}

const String homeDataKey = "Home_Data_Key";
const String storeDetailsKey = "Store_Details_Key";

const int constTimeHomeData = 60 *
    1000; // this is interviel time or the time for check cached and this time is 1 min in millsec

const int constTimeStoreData = 60 *
    1000; // this is interviel time or the time for check cached and this time is 1 min in millsec

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedData> cacheMap = {};

  @override
  Future<HomeResponse> getHomeDataCached() async {
    CachedData? homeDataCached = cacheMap[homeDataKey];
    if (homeDataCached != null &&
        homeDataCached.isTimeValid(constTimeHomeData)) {
      // return home response because this data is already saved in cache map
      return homeDataCached.data;
    } else {
      // we create this homeDataCached local variable nullable because this variable maybe will be null if this cache don't have an home response data or used for first time
      // return error or this time for cache is end so will return invalid error
      throw ErrorHandler.handle(ErrorHandlerCases.cacheError);
    }
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    // this is function for save data return from api we will save it into map data
    cacheMap[homeDataKey] = CachedData(data: homeResponse);
  }

  @override
  void clearCache() {
    // this is function for clear all data on the cache
    cacheMap.clear();
  }

  @override
  void removeDataFromCache(String key) {
    // this is fucntion for clear the data with this key in this cache
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getDetailsDataCached() async {
    CachedData? storeDataCached = cacheMap[storeDetailsKey];

    if (storeDataCached != null &&
        storeDataCached.isTimeValid(constTimeStoreData)) {
      // return home response because this data is already saved in cache map
      return storeDataCached.data;
    } else {
      // we create this homeDataCached local variable nullable because this variable maybe will be null if this cache don't have an home response data or used for first time
      // return error or this time for cache is end so will return invalid error
      throw ErrorHandler.handle(ErrorHandlerCases.cacheError);
    }
  }

  @override
  Future<void> saveDetailsDataToCache(
      StoreDetailsResponse storeDetailsResponse) async {
    cacheMap[storeDetailsKey] = CachedData(data: storeDetailsResponse);
  }
}

class CachedData {
  // we create data is dynamic because this data will may take an (home response , storeDetails response , any response excluded authentication response)
  dynamic data;

  //  this is time will calc if you will get the data from cache or from api
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedData({required this.data});
}

extension CachedDataExtension on CachedData {
  bool isTimeValid(int theConstTime) {
    // this is time will chage every the time will change
    int theCurrentTimeWillChangeEveryTime =
        DateTime.now().millisecondsSinceEpoch;

    bool isValid =
        theCurrentTimeWillChangeEveryTime - cacheTime <= constTimeHomeData;

    return isValid;

    // 1- theCurrentTimeWillChangeEveryTime = 1:00:00
    // 2- cacheTime = 12:59:30
    // 3- homeDataConstTime = 60 millse
    // 1:00:00 - 12:59:30 = 30 millse
    // and the homDataConstTime = 60 millse
    // RESULT => 30 millse is small Than 60 millse so we will return true
    // valid => cacheTime = 1:00:30
  }
}
