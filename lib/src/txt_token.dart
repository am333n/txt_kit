import 'dart:ui';

import 'package:flutter/material.dart' hide FontStyle;
import 'package:flutter/material.dart' as material show FontStyle;

// ---------------------------------------------------------------------------
// TxtSpec  —  one semantic style definition (size + weight + family + extras)
// Every app can create its own token map using these.
// ---------------------------------------------------------------------------

class TxtSpec {
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height; // line-height multiplier
  final Color? color;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final material.FontStyle? fontStyle; // italic / normal
  final Paint? foreground;
  final Paint? background;
  final List<Shadow>? shadows;

  const TxtSpec({
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    this.letterSpacing,
    this.wordSpacing,
    this.height,
    this.color,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.fontStyle,
    this.foreground,
    this.background,
    this.shadows,
  });

  // -------------------------------------------------------------------------
  // copyWith — override any property at call-site
  // -------------------------------------------------------------------------
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
    material.FontStyle? fontStyle,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
  }) {
    return TxtSpec(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontFamily: fontFamily ?? this.fontFamily,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      height: height ?? this.height,
      color: color ?? this.color,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      fontStyle: fontStyle ?? this.fontStyle,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
    );
  }

  // -------------------------------------------------------------------------
  // merge — lower-priority base merged with higher-priority override
  // -------------------------------------------------------------------------
  TxtSpec merge(TxtSpec? other) {
    if (other == null) return this;
    return copyWith(
      fontSize: other.fontSize,
      fontWeight: other.fontWeight,
      fontFamily: other.fontFamily,
      letterSpacing: other.letterSpacing,
      wordSpacing: other.wordSpacing,
      height: other.height,
      color: other.color,
      decoration: other.decoration,
      decorationColor: other.decorationColor,
      decorationStyle: other.decorationStyle,
      decorationThickness: other.decorationThickness,
      fontStyle: other.fontStyle,
      foreground: other.foreground,
      background: other.background,
      shadows: other.shadows,
    );
  }

  // -------------------------------------------------------------------------
  // toTextStyle — resolve to Flutter's native TextStyle
  // -------------------------------------------------------------------------
  TextStyle toTextStyle({Color? colorOverride, String? fontFamilyFallback}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? fontFamilyFallback,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      color: colorOverride ?? color,
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

  static TxtSpec lerp(TxtSpec a, TxtSpec b, double t) {
    return TxtSpec(
      fontSize: lerpDouble(a.fontSize, b.fontSize, t)!,
      letterSpacing: lerpDouble(a.letterSpacing, b.letterSpacing, t),
      wordSpacing: lerpDouble(a.wordSpacing, b.wordSpacing, t),
      height: lerpDouble(a.height, b.height, t),
      decorationThickness:
          lerpDouble(a.decorationThickness, b.decorationThickness, t),
      fontWeight: FontWeight.lerp(a.fontWeight, b.fontWeight, t)!,
      color: Color.lerp(a.color, b.color, t),
      decorationColor: Color.lerp(a.decorationColor, b.decorationColor, t),
      shadows: Shadow.lerpList(a.shadows, b.shadows, t),
      fontFamily: t < 0.5 ? a.fontFamily : b.fontFamily,
      decoration: t < 0.5 ? a.decoration : b.decoration,
      decorationStyle: t < 0.5 ? a.decorationStyle : b.decorationStyle,
      fontStyle: t < 0.5 ? a.fontStyle : b.fontStyle,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      background: t < 0.5 ? a.background : b.background,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TxtSpec &&
          other.fontSize == fontSize &&
          other.fontWeight == fontWeight &&
          other.fontFamily == fontFamily;

  @override
  int get hashCode => Object.hash(fontSize, fontWeight, fontFamily);
}
