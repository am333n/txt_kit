import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// TxtColorScheme  —  semantic color roles for text.
// Apps supply their own instance inside [TxtTheme].
// ---------------------------------------------------------------------------

class TxtColorScheme {
  /// Default body / heading text.
  final Color primary;

  /// Muted / supporting text (captions, hints).
  final Color secondary;

  /// Disabled or placeholder text.
  final Color tertiary;

  /// Text on dark / colored surfaces (e.g. buttons, banners).
  final Color onDark;

  /// Error / destructive text.
  final Color error;

  /// Success state text.
  final Color success;

  /// Warning state text.
  final Color warning;

  const TxtColorScheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.onDark,
    this.error = const Color(0xFFD32F2F),
    this.success = const Color(0xFF388E3C),
    this.warning = const Color(0xFFF57C00),
  });

  // ── Built-in light preset ──────────────────────────────────────────────────
  static const TxtColorScheme light = TxtColorScheme(
    primary: Color(0xFF1A1A1A),
    secondary: Color(0xFF757575),
    tertiary: Color(0xFFBDBDBD),
    onDark: Color(0xFFFFFFFF),
  );

  // ── Built-in dark preset ───────────────────────────────────────────────────
  static const TxtColorScheme dark = TxtColorScheme(
    primary: Color(0xFFF5F5F5),
    secondary: Color(0xFFB0B0B0),
    tertiary: Color(0xFF616161),
    onDark: Color(0xFF1A1A1A),
  );

  TxtColorScheme copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? onDark,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return TxtColorScheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      onDark: onDark ?? this.onDark,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  static TxtColorScheme lerp(TxtColorScheme a, TxtColorScheme b, double t) {
    return TxtColorScheme(
      primary: Color.lerp(a.primary, b.primary, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      tertiary: Color.lerp(a.tertiary, b.tertiary, t)!,
      onDark: Color.lerp(a.onDark, b.onDark, t)!,
      error: Color.lerp(a.error, b.error, t)!,
      success: Color.lerp(a.success, b.success, t)!,
      warning: Color.lerp(a.warning, b.warning, t)!,
    );
  }
}

// ---------------------------------------------------------------------------
// TxtColorRole  —  semantic role selector used on [Txt] widget
// ---------------------------------------------------------------------------

enum TxtColorRole {
  primary,
  secondary,
  tertiary,
  onDark,
  error,
  success,
  warning,
}
