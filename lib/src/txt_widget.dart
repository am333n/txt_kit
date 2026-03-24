import 'package:flutter/material.dart' hide FontStyle;

import 'txt_color_scheme.dart';
import 'txt_theme.dart';
import 'txt_token.dart';

// ---------------------------------------------------------------------------
// Txt  —  the main text widget.
//
// Usage examples
// ──────────────
//
// Basic:
//   Txt('Hello world', style: TxtStyle.bodyLBold)
//
// copyWith on the spec:
//   Txt('Hello world', style: TxtStyle.bodyLBold.spec.copyWith(color: Colors.red))
//
// Custom app style key:
//   Txt('Hello world', style: AppTxtStyle.heroTitle)
//
// Explicit color role:
//   Txt('Muted text', style: TxtStyle.bodyMRegular, colorRole: TxtColorRole.secondary)
//
// Direct color override (highest priority):
//   Txt('Red text', style: TxtStyle.bodyMRegular, color: Colors.red)
// ---------------------------------------------------------------------------

class Txt extends StatelessWidget {
  /// The text to display.
  final String text;

  /// A built-in [TxtStyle] enum value, an app-level custom style key (any
  /// Object registered in [TxtThemeData.customSpecs]), or a raw [TxtSpec]
  /// built via copyWith.
  ///
  /// Accepts:
  ///   • [TxtStyle]          — built-in semantic spec
  ///   • Any custom enum     — must be registered in TxtThemeData.customSpecs
  ///   • [TxtSpec]          — raw / pre-built spec (from .copyWith chains)
  final Object style;

  /// Semantic color role from [TxtColorScheme]. Ignored when [color] is set.
  final TxtColorRole? colorRole;

  /// Direct color override. Takes priority over [colorRole] and spec color.
  final Color? color;

  /// Constrain the widget width.
  final double? width;

  /// Constrain the widget height.
  final double? height;

  final TextAlign? textAlign;

  /// 0 = unlimited lines.
  final int? maxLines;

  final TextOverflow overflow;

  const Txt(
    this.text, {
    super.key,
    this.style = _defaultStyle,
    this.colorRole,
    this.color,
    this.width,
    this.height,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
  });

  static const Object _defaultStyle = _BuiltinDefault();

  @override
  Widget build(BuildContext context) {
    final theme = TxtTheme.of(context);

    // ── 1. Resolve spec ─────────────────────────────────────────────────────
    final TxtSpec spec = _resolveToken(style, theme);

    // ── 2. Resolve color ─────────────────────────────────────────────────────
    final Color? resolvedColor = _resolveColor(color, colorRole, spec, theme);

    // ── 3. Build TextStyle ───────────────────────────────────────────────────
    final textStyle = spec.toTextStyle(
      colorOverride: resolvedColor,
      fontFamilyFallback: theme.defaultFontFamily,
    );

    // ── 4. Render ────────────────────────────────────────────────────────────
    return SizedBox(
      width: width,
      height: height,
      child: Text(
        text,
        style: textStyle,
        textAlign: textAlign,
        softWrap: true,
        maxLines: maxLines == 0 ? null : maxLines,
        overflow: maxLines == 0 ? null : overflow,
      ),
    );
  }

  static TxtSpec _resolveToken(Object style, TxtThemeData theme) {
    if (style is _BuiltinDefault) {
      return theme.resolve(
        // ignore: invalid_use_of_visible_for_testing_member — safe, internal
        TxtSpec(fontSize: 14, fontWeight: FontWeight.w400),
      );
    }
    if (style is TxtSpec) return style; // raw spec passed directly
    return theme.resolve(style);
  }

  static Color? _resolveColor(
    Color? direct,
    TxtColorRole? role,
    TxtSpec token,
    TxtThemeData theme,
  ) {
    if (direct != null) return direct;
    if (role != null) return _colorFromRole(role, theme.colorScheme);
    return token.color; // may be null → Flutter default
  }

  static Color _colorFromRole(TxtColorRole role, TxtColorScheme cs) {
    switch (role) {
      case TxtColorRole.primary:
        return cs.primary;
      case TxtColorRole.secondary:
        return cs.secondary;
      case TxtColorRole.tertiary:
        return cs.tertiary;
      case TxtColorRole.onDark:
        return cs.onDark;
      case TxtColorRole.error:
        return cs.error;
      case TxtColorRole.success:
        return cs.success;
      case TxtColorRole.warning:
        return cs.warning;
    }
  }
}

// ---------------------------------------------------------------------------
// Internal sentinel for the default style when nothing is passed.
// ---------------------------------------------------------------------------
class _BuiltinDefault {
  const _BuiltinDefault();
}

// ---------------------------------------------------------------------------
// TxtRich  —  rich text helper built on the same spec system.
// ---------------------------------------------------------------------------

/// Build a [TextSpan] from a style key (same resolution rules as [Txt]).
TextSpan txtSpan(
  BuildContext context, {
  String? text,
  required Object style,
  Color? color,
  TxtColorRole? colorRole,
  List<TextSpan>? children,
}) {
  final theme = TxtTheme.of(context);
  final spec = style is TxtSpec ? style : theme.resolve(style);

  Color? resolvedColor = color;
  if (resolvedColor == null && colorRole != null) {
    resolvedColor = Txt._colorFromRole(colorRole, theme.colorScheme);
  }
  resolvedColor ??= spec.color;

  return TextSpan(
    text: text,
    style: spec.toTextStyle(
      colorOverride: resolvedColor,
      fontFamilyFallback: theme.defaultFontFamily,
    ),
    children: children,
  );
}
