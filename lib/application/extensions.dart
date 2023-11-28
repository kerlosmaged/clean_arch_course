// this is file for create an extensions for string and integer because check bout null value
import 'package:app/application/app_constants.dart';

extension NonNullString on String? {
  String checkNull() {
    if (this == null) {
      return AppConstant.emptyString;
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int checkeNull() {
    if (this == null) {
      return AppConstant.emptyZero;
    } else {
      return this!;
    }
  }
}

/**
 * in this file we create an extension on string and int to check null value
 * this is extension class is get used to or replacement the really value will entered 
 * to check an example in dart code go to this path "D:\code\dart projects\extionsion_project\bin" and check this file "extionsion_project.dart"
 */