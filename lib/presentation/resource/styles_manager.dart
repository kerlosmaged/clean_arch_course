import 'package:app/presentation/resource/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle({
  required double fontSize,
  required FontWeight fontWeight,
  required Color color,
}) {
  return TextStyle(
    fontFamily: FontManager.fontName,
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  );
}

TextStyle regularTextStyle({required double fontSize, required Color color}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.regular,
    color: color,
  );
}

TextStyle lightTextStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.light,
    color: color,
  );
}

TextStyle mediumTextStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.medium,
    color: color,
  );
}

TextStyle semiBoldTextStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.semiBold,
    color: color,
  );
}

TextStyle boldTextStyle({
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    fontWeight: FontWeightManager.bold,
    color: color,
  );
}
