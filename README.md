# txt_kit

A robust, reusable Flutter text widget library with per-app theming, custom style tokens, semantic color roles, and `copyWith` support at the call-site.

---

## Features

| Feature | Description |
|---|---|
| **Built-in tokens** | 27 semantic styles (`bodyLBold`, `headerMSemiBold`, etc.) |
| **`copyWith` at call-site** | `TxtStyle.bodyLBold.copyWith(color: Colors.red)` |
| **Per-app themes** | Override built-in tokens per-app via `TxtThemeData` |
| **Custom style keys** | Register your own enum values (`AppTxtStyle.heroTitle`) |
| **Semantic colors** | `TxtColorRole.secondary` instead of hard-coded hex |
| **Custom font per app** | `defaultFontFamily` + per-token `fontFamily` overrides |
| **RichText support** | `txtSpan()` uses the same resolution pipeline |
| **No dependencies** | Pure Flutter, zero third-party packages |

---

## Installation

```yaml
# pubspec.yaml
dependencies:
  txt_kit:
    git:
      url: https://github.com/yourorg/txt_kit.git
```

---

## Setup — Wrap your app once

```dart
import 'package:txt_kit/txt_kit.dart';

// Define your own style keys (optional but recommended)
enum AppTxtStyle { heroTitle, priceBig, badge, codeSnippet }

void main() {
  runApp(
    TxtTheme(
      data: TxtThemeData(
        // App-wide font family
        defaultFontFamily: 'Inter',

        // Semantic text colors for this app
        colorScheme: const TxtColorScheme(
          primary:   Color(0xFF111827),
          secondary: Color(0xFF6B7280),
          tertiary:  Color(0xFFD1D5DB),
          onDark:    Colors.white,
        ),

        // Override built-in tokens for this app
        tokenOverrides: {
          TxtStyle.bodyLRegular: const TxtSpec(fontSize: 15, fontWeight: FontWeight.w400),
          TxtStyle.headerLBold:  const TxtSpec(fontSize: 36, fontWeight: FontWeight.w800),
        },

        // Register app-level custom style keys
        customTokens: {
          AppTxtStyle.heroTitle: const TxtSpec(
            fontSize: 52,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          AppTxtStyle.codeSnippet: const TxtSpec(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'JetBrainsMono',   // token-level font override
          ),
        },
      ),
      child: const MaterialApp(home: MyHome()),
    ),
  );
}
```

---

## Usage

### Built-in token
```dart
Txt('Hello world', style: TxtStyle.bodyLBold)
```

### `copyWith` at the call-site
```dart
Txt(
  'Custom styled',
  style: TxtStyle.bodyLBold.copyWith(
    color: Colors.red,
    letterSpacing: 1.5,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
  ),
)
```

### App-level custom style
```dart
Txt('Big hero headline', style: AppTxtStyle.heroTitle)
```

### Semantic color role
```dart
Txt('Muted label', style: TxtStyle.bodyMRegular, colorRole: TxtColorRole.secondary)
Txt('Error message', style: TxtStyle.bodyMSemiBold, colorRole: TxtColorRole.error)
```

### Hard-coded color override (highest priority)
```dart
Txt('Brand color', style: TxtStyle.bodyLBold, color: Color(0xFF6366F1))
```

### RichText with `txtSpan`
```dart
RichText(
  text: TextSpan(children: [
    txtSpan(context, text: 'Normal ', style: TxtStyle.bodyLRegular),
    txtSpan(context, text: 'bold red', style: TxtStyle.bodyLBold.copyWith(color: Colors.red)),
    txtSpan(context, text: ' muted.', style: TxtStyle.bodyLRegular, colorRole: TxtColorRole.secondary),
  ]),
)
```

---

## Token resolution priority

```
customTokens[key]           ← 1st: app custom keys
tokenOverrides[key] + base  ← 2nd: merged override of built-in key
TxtDefaults.tokens[key]     ← 3rd: library default
```

---

## Built-in tokens

| Key | Default size | Weight |
|---|---|---|
| `bodyLRegular/SemiBold/Bold` | 14 | 400 / 600 / 700 |
| `bodyMRegular/SemiBold/Bold` | 12 | 400 / 600 / 700 |
| `bodySRegular/SemiBold/Bold` | 10 | 400 / 600 / 700 |
| `headerXSRegular/SemiBold/Bold` | 16 | 400 / 600 / 700 |
| `headerSRegular/SemiBold/Bold` | 20 | 400 / 600 / 700 |
| `headerMRegular/SemiBold/Bold` | 22 | 400 / 600 / 700 |
| `headerLRegular/SemiBold/Bold` | 34 | 400 / 600 / 700 |
| `labelLRegular/SemiBold/Bold` | 10 | 400 / 600 / 700 |
| `labelSRegular/SemiBold/Bold` | 8 | 400 / 600 / 700 |

All sizes are in logical pixels. Override any of them per-app via `tokenOverrides`.

---

## TxtSpec properties

```dart
TxtSpec({
  required double fontSize,
  required FontWeight fontWeight,
  String? fontFamily,       // overrides defaultFontFamily for this token only
  double? letterSpacing,
  double? wordSpacing,
  double? height,           // line-height multiplier
  Color? color,             // baked-in color (lower priority than colorRole / color param)
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
  FontStyle? fontStyle,     // normal / italic
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
})
```