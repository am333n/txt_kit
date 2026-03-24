// ---------------------------------------------------------------------------
// TxtStyle  —  built-in semantic style keys shipped with txt_kit.
//
// Apps can EXTEND this by implementing their own style keys using
// the [TxtStyleKey] interface, and registering them in [TxtTheme].
// ---------------------------------------------------------------------------

/// The interface every style key must implement.
/// Both [TxtStyle] and any app-specific enums satisfy this by implementing it.
abstract class TxtStyleKey {
  String get name;
}

/// Built-in style tokens. These map to default sizes/weights in [TxtDefaults].
enum TxtStyle implements TxtStyleKey {
  // ── Body ──────────────────────────────────────────────────────────────────
  bodyLRegular,
  bodyLSemiBold,
  bodyLBold,
  bodyMRegular,
  bodyMSemiBold,
  bodyMBold,
  bodySRegular,
  bodySSemiBold,
  bodySBold,

  // ── Header ────────────────────────────────────────────────────────────────
  headerXSRegular,
  headerXSSemiBold,
  headerXSBold,
  headerSRegular,
  headerSSemiBold,
  headerSBold,
  headerMRegular,
  headerMSemiBold,
  headerMBold,
  headerLRegular,
  headerLSemiBold,
  headerLBold,

  // ── Label ─────────────────────────────────────────────────────────────────
  labelLRegular,
  labelLSemiBold,
  labelLBold,
  labelSRegular,
  labelSSemiBold,
  labelSBold;

  @override
  String get name => toString().split('.').last;
}
