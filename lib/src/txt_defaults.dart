import 'package:flutter/material.dart';
import 'txt_style.dart';
import 'txt_token.dart';

// ---------------------------------------------------------------------------
// TxtDefaults  —  the out-of-the-box token map for [TxtStyle].
// Apps override this entirely or partially via [TxtTheme].
// ---------------------------------------------------------------------------

class TxtDefaults {
  TxtDefaults._();

  static const String _defaultFamily = 'publicasans';

  static const Map<TxtStyle, TxtSpec> specs = {
    // ── Body L ───────────────────────────────────────────────────────────────
    TxtStyle.bodyLRegular: TxtSpec(
        fontSize: 14, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.bodyLSemiBold: TxtSpec(
        fontSize: 14, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.bodyLBold: TxtSpec(
        fontSize: 14, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Body M ───────────────────────────────────────────────────────────────
    TxtStyle.bodyMRegular: TxtSpec(
        fontSize: 12, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.bodyMSemiBold: TxtSpec(
        fontSize: 12, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.bodyMBold: TxtSpec(
        fontSize: 12, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Body S ───────────────────────────────────────────────────────────────
    TxtStyle.bodySRegular: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.bodySSemiBold: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.bodySBold: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Header XS ────────────────────────────────────────────────────────────
    TxtStyle.headerXSRegular: TxtSpec(
        fontSize: 16, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.headerXSSemiBold: TxtSpec(
        fontSize: 16, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.headerXSBold: TxtSpec(
        fontSize: 16, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Header S ─────────────────────────────────────────────────────────────
    TxtStyle.headerSRegular: TxtSpec(
        fontSize: 20, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.headerSSemiBold: TxtSpec(
        fontSize: 20, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.headerSBold: TxtSpec(
        fontSize: 20, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Header M ─────────────────────────────────────────────────────────────
    TxtStyle.headerMRegular: TxtSpec(
        fontSize: 22, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.headerMSemiBold: TxtSpec(
        fontSize: 22, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.headerMBold: TxtSpec(
        fontSize: 22, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Header L ─────────────────────────────────────────────────────────────
    TxtStyle.headerLRegular: TxtSpec(
        fontSize: 34, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.headerLSemiBold: TxtSpec(
        fontSize: 34, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.headerLBold: TxtSpec(
        fontSize: 34, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Label L ──────────────────────────────────────────────────────────────
    TxtStyle.labelLRegular: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.labelLSemiBold: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.labelLBold: TxtSpec(
        fontSize: 10, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),

    // ── Label S ──────────────────────────────────────────────────────────────
    TxtStyle.labelSRegular: TxtSpec(
        fontSize: 8, fontWeight: FontWeight.w400, fontFamily: _defaultFamily),
    TxtStyle.labelSSemiBold: TxtSpec(
        fontSize: 8, fontWeight: FontWeight.w600, fontFamily: _defaultFamily),
    TxtStyle.labelSBold: TxtSpec(
        fontSize: 8, fontWeight: FontWeight.w700, fontFamily: _defaultFamily),
  };
}
