import 'package:flutter/material.dart' show Border, BorderSide, BoxDecoration;
import '../../core/constants/_app_constants.dart';
import '../../core/app_colors.dart';

part 'ios_card_bd.dart';
part 'ios_dialog_bd.dart';
part 'android_dialog_bd.dart';
part 'android_card_bd.dart';

/// 🧬 [BoxDecorationFactory] — Centralized entry point for theme-based [BoxDecoration]
/// 📦 Provides access to iOS/Android-specific box decorations
/// Used across overlay components and modals

sealed class BoxDecorationFactory {
  const BoxDecorationFactory._();
  // ──────────────────────────────────

  /// 🍏 iOS banner (glassmorphism)
  static BoxDecoration iosCard(bool isDark) =>
      IOSCardsDecoration.fromTheme(isDark);

  /// 🍏 iOS dialog (glassmorphism)
  static BoxDecoration iosDialog(bool isDark) =>
      IOSDialogsDecoration.fromTheme(isDark);

  /// 🤖 Android dialog (Material 3)
  static BoxDecoration androidDialog(bool isDark) =>
      AndroidDialogsDecoration.fromTheme(isDark);

  /// 🍞 Android snackbar
  static BoxDecoration androidCard(bool isDark) =>
      AndroidCardsDecoration.fromTheme(isDark);

  //
}
