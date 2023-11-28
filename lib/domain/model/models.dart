// ignore_for_file: public_member_api_docs, sort_constructors_first
// onBoarding models
class SliderObject {
  final String title;
  final String subTitle;
  final String imagePath;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;
  SliderViewObject({
    required this.sliderObject,
    required this.numberOfSlides,
    required this.currentIndex,
  });
}

// login models
class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer({
    required this.id,
    required this.name,
    required this.numOfNotifications,
  });
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts({
    required this.phone,
    required this.email,
    required this.link,
  });
}

class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication({
    required this.customer,
    required this.contacts,
  });
}

// forgetPassword
class ForgetPassword {
  int status;
  String message;
  String support;
  ForgetPassword({
    required this.status,
    required this.message,
    required this.support,
  });
}

// NOTE: registerMode we used authentication model because don't different in any thing on api

// home model
class Services {
  int id;
  String title;
  String image;

  Services({required this.id, required this.title, required this.image});
}

class BannerAd {
  int id;
  String title;
  String link;
  String image;

  BannerAd({
    required this.id,
    required this.title,
    required this.image,
    required this.link,
  });
}

class Stores {
  int id;
  String title;
  String image;

  Stores({
    required this.id,
    required this.title,
    required this.image,
  });
}

class HomeData {
  List<Services> services;
  List<BannerAd> banner;
  List<Stores> stores;

  HomeData({
    required this.services,
    required this.banner,
    required this.stores,
  });
}

class Home {
  HomeData data;

  Home({required this.data});
}

class StoreDetails {
  String image;

  String title;

  String details;

  String services;

  String about;
  StoreDetails({
    required this.image,
    required this.title,
    required this.details,
    required this.services,
    required this.about,
  });
}
