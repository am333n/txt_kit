/// txt_kit — A robust, reusable Flutter text widget library.
///
/// ## Quick start
///
/// 1. Wrap your app:
/// ```dart
/// TxtTheme(
///   data: TxtThemeData(
///     colorScheme: TxtColorScheme(
///       primary: Color(0xFF1A1A1A),
///       secondary: Color(0xFF757575),
///       tertiary: Color(0xFFBDBDBD),
///       onDark: Colors.white,
///     ),
///     defaultFontFamily: 'YourFont',
///     // override built-in specs:
///     specOverrides: {
///       TxtStyle.bodyLBold: TxtSpec(fontSize: 15, fontWeight: FontWeight.w700),
///     },
///     // add your own app-level style keys:
///     customSpecs: {
///       AppTxtStyle.heroTitle: TxtSpec(fontSize: 48, fontWeight: FontWeight.w800),
///     },
///   ),
///   child: MyApp(),
/// )
/// ```
///
/// 2. Use [Txt] anywhere:
/// ```dart
/// Txt('Hello world', style: TxtStyle.bodyLBold)
/// Txt('Custom', style: TxtStyle.bodyLBold.copyWith(color: Colors.red))
/// Txt('App style', style: AppTxtStyle.heroTitle)
/// Txt('Muted', style: TxtStyle.bodyMRegular, colorRole: TxtColorRole.secondary)
/// ```
library;

export 'src/txt_color_scheme.dart';
export 'src/txt_defaults.dart';
export 'src/txt_style.dart';
export 'src/txt_style_extension.dart';
export 'src/txt_theme.dart';
export 'src/txt_token.dart';
export 'src/txt_widget.dart';
export 'src/txt_extension.dart';
