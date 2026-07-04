import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
  double fontSize,
  String fontFamily,
  FontWeight fontWeight,
  Color? color,
) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

//light text style
TextStyle getLight300Style12({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.light300,
   Color? color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegular400Style10({
  double fontSize = FontSize.s10,
  FontWeight fontWeight = FontWeightManager.regural400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

//regular  text style
TextStyle getRegular400Style12({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.regural400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegular400Style14({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.regural400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getRegular400Style16({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.regural400,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style10({
  double fontSize = FontSize.s10,
  FontWeight fontWeight = FontWeightManager.medium500,
 Color ?color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

//mediun text style
TextStyle getMedium500Style12({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style14({
  double fontSize = FontSize.s14,
  FontWeight fontWeight = FontWeightManager.medium500,
   Color? color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style16({
  double fontSize = FontSize.s16,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style18({
  double fontSize = FontSize.s18,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style20({
  double fontSize = FontSize.s20,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style22({
  double fontSize = FontSize.s22,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMedium500Style28({
  double fontSize = FontSize.s28,
  FontWeight fontWeight = FontWeightManager.medium500,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getSemiBold600Style10({
  double fontSize = FontSize.s10,
  FontWeight fontWeight = FontWeightManager.semiBold600,
  required Color color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

//semi bold text style
TextStyle getSemiBold600Style12({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.semiBold600,
   Color? color,
}) {
  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}