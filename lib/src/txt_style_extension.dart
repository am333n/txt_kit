import 'dart:ui';

import 'txt_defaults.dart';
import 'txt_style.dart';
import 'txt_token.dart';

// ---------------------------------------------------------------------------
// TxtStyleExtension  —  adds .token and .copyWith directly onto [TxtStyle].
//
// This makes the call-site feel like:
//   Txt('Hello', style: TxtStyle.bodyLBold.copyWith(color: Colors.red))
// instead of:
//   Txt('Hello', style: TxtStyle.bodyLBold.token.copyWith(color: Colors.red))
//
// Both forms work. .copyWith is the shorthand.
// ---------------------------------------------------------------------------

extension TxtStyleExtension on TxtStyle {
  /// The default [TxtSpec] for this style from [TxtDefaults].
  /// Note: this is the *library default*, not theme-overridden.
  /// For theme-aware resolution use [TxtThemeData.resolve].
  TxtSpec get token =>
      TxtDefaults.specs[this] ??
      const TxtSpec(fontSize: 14, fontWeight: FontWeight.w400);

  /// Shorthand: starts from the default token and applies overrides.
  ///
  /// ```dart
  /// Txt('Hello', style: TxtStyle.bodyLBold.copyWith(
  ///   color: Colors.red,
  ///   letterSpacing: 1.2,
  /// ))
  /// ```
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
  }) {
    return token.copyWith(
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
  }
}
