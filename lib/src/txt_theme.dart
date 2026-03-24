import 'package:flutter/material.dart';
import 'txt_color_scheme.dart';
import 'txt_defaults.dart';
import 'txt_style.dart';
import 'txt_token.dart';

// ---------------------------------------------------------------------------
// TxtThemeData  —  immutable config object apps pass to [TxtTheme].
// ---------------------------------------------------------------------------

class TxtThemeData {
  /// Semantic color roles for text.
  final TxtColorScheme colorScheme;

  /// Global font family applied when a token doesn't specify its own.
  final String? defaultFontFamily;

  /// Overrides for built-in [TxtStyle] specs.
  /// Provide only the specs you want to change — the rest use [TxtDefaults].
  final Map<TxtStyle, TxtSpec> tokenOverrides;

  /// Extra custom style keys (your own enum values, e.g. `AppTxtStyle`).
  /// These are resolved first, before built-in specs.
  final Map<Object, TxtSpec> customSpecs;

  const TxtThemeData({
    this.colorScheme = TxtColorScheme.light,
    this.defaultFontFamily,
    this.tokenOverrides = const {},
    this.customSpecs = const {},
  });

  TxtThemeData copyWith({
    TxtColorScheme? colorScheme,
    String? defaultFontFamily,
    Map<TxtStyle, TxtSpec>? tokenOverrides,
    Map<Object, TxtSpec>? customSpecs,
  }) {
    return TxtThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
      tokenOverrides: tokenOverrides ?? this.tokenOverrides,
      customSpecs: customSpecs ?? this.customSpecs,
    );
  }

  // ── Resolution logic ───────────────────────────────────────────────────────

  /// Resolve any style key (built-in [TxtStyle] or a custom app key) to a
  /// [TxtSpec]. Priority:
  ///   1. customSpecs   (app's own keys + full custom specs)
  ///   2. tokenOverrides (app overrides of built-in keys)
  ///   3. TxtDefaults    (library defaults)
  TxtSpec resolve(Object styleKey) {
    // 1 — custom specs registered by the app
    if (customSpecs.containsKey(styleKey)) {
      return customSpecs[styleKey]!;
    }

    // 2 — overrides of built-in specs
    if (styleKey is TxtStyle && tokenOverrides.containsKey(styleKey)) {
      final base = TxtDefaults.specs[styleKey]!;
      final override = tokenOverrides[styleKey]!;
      return base.merge(override);
    }

    // 3 — built-in defaults
    if (styleKey is TxtStyle) {
      return TxtDefaults.specs[styleKey] ??
          const TxtSpec(fontSize: 14, fontWeight: FontWeight.w400);
    }

    throw ArgumentError(
      'Unknown style key "$styleKey". '
      'Register it via TxtThemeData.customSpecs.',
    );
  }

  // -------------------------------------------------------------------------
  // lerp — called by TxtTheme when wrapping with AnimatedTheme
  // -------------------------------------------------------------------------
  static TxtThemeData lerp(TxtThemeData a, TxtThemeData b, double t) {
    return TxtThemeData(
      colorScheme: TxtColorScheme.lerp(a.colorScheme, b.colorScheme, t),
      defaultFontFamily: t < 0.5 ? a.defaultFontFamily : b.defaultFontFamily,
      tokenOverrides: _lerpTokenMap(a.tokenOverrides, b.tokenOverrides, t),
      customSpecs: _lerpTokenMap(a.customSpecs, b.customSpecs, t),
    );
  }

  static Map<K, TxtSpec> _lerpTokenMap<K>(
    Map<K, TxtSpec> a,
    Map<K, TxtSpec> b,
    double t,
  ) {
    final keys = {...a.keys, ...b.keys};
    return {
      for (final k in keys)
        k: TxtSpec.lerp(
          a[k] ?? b[k]!, // if missing in a, snap from b
          b[k] ?? a[k]!, // if missing in b, snap from a
          t,
        ),
    };
  }
}

// ---------------------------------------------------------------------------
// TxtTheme  —  InheritedWidget that wraps your app (or a subtree).
// ---------------------------------------------------------------------------

class TxtTheme extends StatefulWidget {
  final TxtThemeData data;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const TxtTheme({
    super.key,
    required this.data,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  /// Nearest [TxtThemeData] in the tree, or a default light theme if none.
  static TxtThemeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_TxtThemeInherited>();
    return inherited?.data ?? const TxtThemeData();
  }

  /// Like [of] but doesn't subscribe to updates.
  static TxtThemeData? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<_TxtThemeInherited>()?.data;
  }

  @override
  State<TxtTheme> createState() => _TxtThemeState();
}

class _TxtThemeState extends State<TxtTheme> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<TxtThemeData>(
      tween: _TxtThemeDataTween(end: widget.data),
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, value, child) => _TxtThemeInherited(
        data: value,
        child: child!,
      ),
      child: widget.child,
    );
  }
}

// ---------------------------------------------------------------------------
// Internal InheritedWidget — consumers still call TxtTheme.of(context),
// they never touch this directly.
// ---------------------------------------------------------------------------
class _TxtThemeInherited extends InheritedWidget {
  final TxtThemeData data;

  const _TxtThemeInherited({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_TxtThemeInherited oldWidget) =>
      data != oldWidget.data;
}

// ---------------------------------------------------------------------------
// Tween — drives the lerp between two TxtThemeData values
// ---------------------------------------------------------------------------
class _TxtThemeDataTween extends Tween<TxtThemeData> {
  _TxtThemeDataTween({super.end});

  @override
  TxtThemeData lerp(double t) => TxtThemeData.lerp(begin!, end!, t);
}
