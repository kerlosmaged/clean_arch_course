// this is extension on Response (Customer , Contact ,Authentication)
import 'package:app/application/app_constants.dart';
import 'package:app/application/extensions.dart';
import 'package:app/data/response/responses.dart';
import 'package:app/domain/model/models.dart';

// this is extionsion for convert the response you will return it from internet to model object
extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      phone: this?.phone.checkNull() ?? AppConstant.emptyString,
      email: this?.email.checkNull() ?? AppConstant.emptyString,
      link: this?.link.checkNull() ?? AppConstant.emptyString,
    );
  }
}

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      name: this?.name.checkNull() ?? AppConstant.emptyString,
      id: this?.id.checkNull() ?? AppConstant.emptyString,
      numOfNotifications:
          this?.numOfNotifications.checkeNull() ?? AppConstant.emptyZero,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      customer: this?.customer.toDomain(),
      contacts: this?.contacts.toDomain(),
    );
  }
}

extension ForgetPasswordResponseMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(
      status: this?.status.checkeNull() ?? AppConstant.emptyZero,
      message: this?.message.checkNull() ?? AppConstant.emptyString,
      support: this?.support.checkNull() ?? AppConstant.emptyString,
    );
  }
}

extension ServicesResponseMapper on ServicesResponse? {
  Services toDomain() {
    return Services(
      id: this?.id.checkeNull() ?? AppConstant.emptyZero,
      title: this?.title.checkNull() ?? AppConstant.emptyString,
      image: this?.image.checkNull() ?? AppConstant.emptyString,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
      id: this?.id.checkeNull() ?? AppConstant.emptyZero,
      title: this?.title.checkNull() ?? AppConstant.emptyString,
      image: this?.image.checkNull() ?? AppConstant.emptyString,
      link: this?.link.checkNull() ?? AppConstant.emptyString,
    );
  }
}

extension StoresResponseMapper on StoresResponse? {
  Stores toDomain() {
    return Stores(
      id: this?.id.checkeNull() ?? AppConstant.emptyZero,
      title: this?.title.checkNull() ?? AppConstant.emptyString,
      image: this?.image.checkNull() ?? AppConstant.emptyString,
    );
  }
}

extension HomeDataResponseMapper on HomeResponse? {
  Home toDomain() {
    // here we get the services like every past domain we create it but here we worked with list so we need to create map on this list to convert every single item from response to domain or to model
    // 1- we get this item by using map
    // 2- take this item and convert it toDomain
    // 3- check every item if any null check have nullable value will generate empty list have type like the list you iterate about it (if you generate list type of it services so you need to create empty list services)
    List<Services> servicesResponse = (this
                ?.data
                ?.servicesResponse
                ?.map((servicesItem) => servicesItem.toDomain()) ??
            const Iterable.empty())
        .cast<Services>()
        .toList();
    // 1- we catch the bannerItem from bannerResponse
    // 2- we convert this item to domain
    // 3- after we create it to domain we will check if this item nullable
    // 4- if this item is nullable we will generate empty list
    // 5- if this item is empty we will generate empty list same as the type of this list
    List<BannerAd> bannerResponse = (this
                ?.data
                ?.bannerResponse
                ?.map((bannerresponseItem) => bannerresponseItem.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    // 1- we will catch the every single item on this response will back
    // 2- after we catch this item we will convert it toDomain
    // 3- if this item nullable will generate empty iterable
    // 4- we will convert this empty iterable to type of this list
    // 5- we will convert this iterable to list

    List<Stores> storesResponse =
        (this?.data?.storesResponse?.map((storeItem) => storeItem.toDomain()) ??
                const Iterable.empty())
            .cast<Stores>()
            .toList();

    var data = HomeData(
      services: servicesResponse,
      banner: bannerResponse,
      stores: storesResponse,
    );

    return Home(data: data);
  }
}

extension AllDataResponseMapper on HomeDataResponse? {
  HomeData toDomain() {
    return HomeData(
      services:
          (this?.servicesResponse?.map((storeItem) => storeItem.toDomain()) ??
                  const Iterable.empty())
              .cast<Services>()
              .toList(),
      banner:
          (this?.bannerResponse?.map((bannerItem) => bannerItem.toDomain()) ??
                  const Iterable.empty())
              .cast<BannerAd>()
              .toList(),
      stores:
          (this?.storesResponse?.map((storesItem) => storesItem.toDomain()) ??
                  const Iterable.empty())
              .cast<Stores>()
              .toList(),
    );
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      image: this?.image.checkNull() ?? AppConstant.emptyString,
      title: this?.title.checkNull() ?? AppConstant.emptyString,
      details: this?.details.checkNull() ?? AppConstant.emptyString,
      services: this?.services.checkNull() ?? AppConstant.emptyString,
      about: this?.about.checkNull() ?? AppConstant.emptyString,
    );
  }
}
