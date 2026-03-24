import 'package:flutter/painting.dart';
import 'package:txt_kit/txt_kit.dart';

extension TxtStyleExtension on TxtStyle {
  TxtSpec get spec =>
      TxtDefaults.specs[this] ??
      const TxtSpec(fontSize: 14, fontWeight: FontWeight.w400);

  TxtSpec copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle? fontStyle,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
  }) =>
      spec.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        fontStyle: fontStyle,
        foreground: foreground,
        background: background,
        shadows: shadows,
      );

  TextStyle toTextStyle({
    Color? color,
    String? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
  }) =>
      spec
          .copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
            height: height,
          )
          .toTextStyle(fontFamilyFallback: fontFamilyFallback);
}
