# txt_kit

A robust, reusable Flutter text widget library with per-app theming, custom style specs, semantic color roles, and `copyWith` support at the call-site.

---

## Features

| Feature | Description |
|---|---|
| **Built-in Specs** | 27 semantic styles (`bodyLBold`, `headerMSemiBold`, etc.) |
| **`copyWith` at call-site** | `TxtStyle.bodyLBold.copyWith(color: Colors.red)` |
| **Per-app themes** | Override built-in specs per-app via `TxtThemeData` |
| **Custom style keys** | Register your own enum values (`AppTxtStyle.heroTitle`) |
| **Semantic colors** | `TxtColorRole.secondary` instead of hard-coded hex |
| **Custom font per app** | `defaultFontFamily` + per-spec `fontFamily` overrides |
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

        // Override built-in specs for this app
        specOverrides: {
          TxtStyle.bodyLRegular: const TxtSpec(fontSize: 15, fontWeight: FontWeight.w400),
          TxtStyle.headerLBold:  const TxtSpec(fontSize: 36, fontWeight: FontWeight.w800),
        },

        // Register app-level custom style keys
        customSpecs: {
          AppTxtStyle.heroTitle: const TxtSpec(
            fontSize: 52,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            height: 1.1,
          ),
          AppTxtStyle.codeSnippet: const TxtSpec(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'JetBrainsMono',   // specs-level font override
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

### Built-in specs
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

## Using `toTextStyle()` with Flutter's native `Text` widget

If you need to use txt_kit styles outside of the `Txt` widget — for example inside
Flutter's own `Text`, `DefaultTextStyle`, `TextTheme`, or any third-party widget
that accepts a `TextStyle` — use `.toTextStyle()`.

---

### Basic usage
```dart
Text(
  'Hello world',
  style: TxtStyle.bodyLBold.toTextStyle(),
)
```

---

### With color override
```dart
Text(
  'Red text',
  style: TxtStyle.bodyLBold.toTextStyle(color: Colors.red),
)
```

---

### With multiple overrides
```dart
Text(
  'Custom',
  style: TxtStyle.headerMBold.toTextStyle(
    color: Colors.indigo,
    fontSize: 28,
    letterSpacing: 1.5,
    height: 1.4,
  ),
)
```

---

### With `DefaultTextStyle`
```dart
DefaultTextStyle(
  style: TxtStyle.bodyLRegular.toTextStyle(color: Colors.grey),
  child: Column(
    children: [
      Text('Inherits the style'),
      Text('This too'),
    ],
  ),
)
```

---

### With `TextTheme` in `MaterialApp`
```dart
MaterialApp(
  theme: ThemeData(
    textTheme: TextTheme(
      bodyLarge:   TxtStyle.bodyLRegular.toTextStyle(),
      bodyMedium:  TxtStyle.bodyMRegular.toTextStyle(),
      titleLarge:  TxtStyle.headerMBold.toTextStyle(),
      headlineLarge: TxtStyle.headerLBold.toTextStyle(),
    ),
  ),
)
```

---

### With a custom app font
```dart
Text(
  'Inter font',
  style: TxtStyle.bodyLRegular.toTextStyle(
    fontFamilyFallback: 'Inter',
  ),
)
```

---

### `.copyWith()` vs `.toTextStyle()` — which to use?

| | Returns | Use when |
|---|---|---|
| `TxtStyle.bodyLBold.copyWith(...)` | `TxtSpec` | Passing to `Txt` widget or `TxtSpan` |
| `TxtStyle.bodyLBold.toTextStyle(...)` | `TextStyle` | Passing to `Text`, `DefaultTextStyle`, `TextTheme`, or any third-party widget |

> **Rule of thumb:** inside your own UI use `Txt` and `TxtSpan` — they handle
> theme resolution and color roles automatically. Only drop down to
> `.toTextStyle()` when integrating with widgets that require a raw `TextStyle`.



### RichText with `TxtSpan`
```dart
RichText(
  text: TextSpan(children: [
    TxtSpan(context, text: 'Normal ',  style: TxtStyle.bodyLRegular),
    TxtSpan(context, text: 'Bold red', style: TxtStyle.bodyLBold.copyWith(color: Colors.red)),
    TxtSpan(context, text: ' muted.',  style: TxtStyle.bodyLRegular, colorRole: TxtColorRole.secondary),
  ]),
)
```

---

### With a tap recognizer
```dart
RichText(
  text: TextSpan(children: [
    TxtSpan(context, text: 'By continuing you agree to our ', style: TxtStyle.bodyMRegular),
    TxtSpan(
      context,
      text: 'Terms of Service',
      style: TxtStyle.bodyMBold.copyWith(
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = () => launchTerms(),
    ),
    TxtSpan(context, text: ' and ', style: TxtStyle.bodyMRegular),
    TxtSpan(
      context,
      text: 'Privacy Policy',
      style: TxtStyle.bodyMBold.copyWith(
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = () => launchPrivacy(),
    ),
  ]),
)
```

---

### With color roles
```dart
RichText(
  text: TextSpan(children: [
    TxtSpan(context, text: 'Status: ',  style: TxtStyle.bodyLRegular, colorRole: TxtColorRole.secondary),
    TxtSpan(context, text: 'Payment failed', style: TxtStyle.bodyLBold, colorRole: TxtColorRole.error),
  ]),
)
```

---

### Deprecated — do not use

The following top-level functions are deprecated and will be removed in a future version.
Use `TxtSpan` directly instead.
```dart
// ❌ Deprecated
txtSpan(context, text: 'hello', style: TxtStyle.bodyLRegular)
txtSpanOf(context, text: 'hello', style: TxtStyle.bodyLRegular)
textSpan(context, text: 'hello', style: TxtStyle.bodyLRegular)

// ✅ Use this
TxtSpan(context, text: 'hello', style: TxtStyle.bodyLRegular)
```
---

## Spec resolution priority

```
customSpecs[key]           ← 1st: app custom keys
specsOverrides[key] + base  ← 2nd: merged override of built-in key
TxtDefaults.specss[key]     ← 3rd: library default
```

---

## Built-in specs

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

All sizes are in logical pixels. Override any of them per-app via `specsOverrides`.

---

## TxtSpec properties

```dart
TxtSpec({
  required double fontSize,
  required FontWeight fontWeight,
  String? fontFamily,       // overrides defaultFontFamily for this spec only
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