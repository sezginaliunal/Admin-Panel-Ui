import 'package:flutter/material.dart';

/// Dark Mode için renk paleti
/// Pastel tonları ile yumuşak, modern ve göz yormayan admin panel teması
class DarkColors {
  // === PRIMARY COLORS === (Pastel Light Blue-Grey)
  static const primary = Color(0xFFD1D5DB); // Warm Grey
  static const onPrimary = Color(0xFF000000);
  static const primaryContainer = Color(0xFF374151); // Warm Dark Grey
  static const onPrimaryContainer = Color(0xFFE5E7EB);

  // === SECONDARY COLORS === (Pastel Purple-Grey)
  static const secondary = Color(0xFFB8B5C8); // Soft Lavender-Grey
  static const onSecondary = Color(0xFF1F1F23);
  static const secondaryContainer = Color(0xFF2D2D35);
  static const onSecondaryContainer = Color(0xFFE8E6F0);

  // === TERTIARY COLORS === (Pastel Blue)
  static const tertiary = Color(0xFF93C5FD); // Soft Blue
  static const onTertiary = Color(0xFF000000);
  static const tertiaryContainer = Color(0xFF1E3A5F);
  static const onTertiaryContainer = Color(0xFFDBEAFE);

  // === BACKGROUND & SURFACE ===
  static const background = Color(0xFF1C1B22); // Yumuşak koyu mor-gri pastel
  static const onBackground = Color(0xFFE5E7EB);
  static const surface = Color(0xFF252134); // Pastel mor-gri (card için uyumlu)
  static const onSurface = Color(0xFFE5E7EB);
  static const surfaceVariant = Color(0xFF2F2B3E); // Daha açık mor-gri
  static const onSurfaceVariant = Color(0xFFD1D5DB);

  // === ERROR COLORS === (Pastel Red/Pink)
  static const error = Color(0xFFFCA5A5); // Soft Pink-Red
  static const onError = Color(0xFF000000);
  static const errorContainer = Color(0xFF4C1D1D);
  static const onErrorContainer = Color(0xFFFEE2E2);

  // === SUCCESS COLORS === (Pastel Green)
  static const success = Color(0xFF86EFAC); // Soft Mint Green
  static const onSuccess = Color(0xFF000000);
  static const successContainer = Color(0xFF1A3A26);
  static const onSuccessContainer = Color(0xFFDCFCE7);

  // === WARNING COLORS === (Pastel Amber/Peach)
  static const warning = Color(0xFFFCD34D); // Soft Yellow
  static const onWarning = Color(0xFF000000);
  static const warningContainer = Color(0xFF4A3010);
  static const onWarningContainer = Color(0xFFFEF3C7);

  // === INFO COLORS === (Pastel Cyan)
  static const info = Color(0xFF7DD3FC); // Soft Sky Blue
  static const onInfo = Color(0xFF000000);
  static const infoContainer = Color(0xFF164E63);
  static const onInfoContainer = Color(0xFFE0F2FE);

  // === OUTLINE & BORDERS ===
  static const outline = Color(0xFF3D3850);
  static const outlineVariant = Color(0xFF4A4560);
  static const shadow = Color(0x4D000000);
  static const scrim = Color(0x99000000);

  // === APP BAR ===
  static const appBarBackground = Color(0xFF252134);
  static const appBarForeground = Color(0xFFE5E7EB);

  // === BOTTOM NAVIGATION ===
  static const bottomNavBackground = Color(0xFF252134);
  static const bottomNavSelected = Color(0xFFD1D5DB);
  static const bottomNavUnselected = Color(0xFF6B7280);

  // === CARDS ===
  static const cardBackground = Color(
    0xFF252134,
  ); // Surface ile aynı, uyumlu pastel
  static const cardShadow = Color(0x33000000);
  static const cardBorder = Color(0xFF3D3850);

  // === BUTTONS ===
  static const buttonPrimary = Color(0xFFD1D5DB);
  static const buttonSecondary = Color(0xFF2D2D35);
  static const buttonDisabled = Color(0xFF1F1F28);
  static const onButtonDisabled = Color(0xFF52525B);

  // === TEXT FIELDS ===
  static const textFieldBackground = Color(0xFF2F2B3E);
  static const textFieldBorder = Color(0xFF3D3850);
  static const textFieldBorderFocused = Color(0xFF93C5FD);
  static const textFieldBorderError = Color(0xFFFCA5A5);
  static const textFieldHint = Color(0xFF6B7280);
  static const textFieldText = Color(0xFFE5E7EB);
  static const textFieldLabel = Color(0xFFB8B5C8);

  // === DIVIDERS ===
  static const divider = Color(0xFF2D2D35);
  static const dividerThick = Color(0xFF3F3F46);

  // === CHIPS & TAGS ===
  static const chipBackground = Color(0xFF2D2D35);
  static const chipForeground = Color(0xFFD1D5DB);
  static const chipBorder = Color(0xFF3F3F46);

  // === ICONS ===
  static const iconPrimary = Color(0xFFD1D5DB);
  static const iconSecondary = Color(0xFFB8B5C8);
  static const iconDisabled = Color(0xFF52525B);

  // === OVERLAY & BACKDROP ===
  static const overlay = Color(0x33000000);
  static const backdrop = Color(0xBF000000);

  // === STATUS ===
  static const disabled = Color(0xFF1F1F28);
  static const inactive = Color(0xFF3F3F46);

  DarkColors._();
}
