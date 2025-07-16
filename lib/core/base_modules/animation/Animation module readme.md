# 🧭 Overlay Animation Engine — Developer Guide

> A modular, extensible and platform-adaptive animation system for Flutter overlays (dialogs, banners, snackbars).

---

## 🔧 Overview

This module provides a unified way to animate overlay UI elements using platform-native transitions.
It is structured around the concept of `AnimationEngine`s — injectable, platform-aware animation drivers
that encapsulate animation lifecycle and configuration.

The system is fully declarative and uses a config-driven architecture
to minimize boilerplate, improve maintainability, and ensure scalability.

---

## 📦 Architecture

```text
lib/
├── core/
│   └── overlay_core_types.dart
├── shared_modules/
│   └── animation/
    ├── overlays_animation
│   ├── animation_engines
│   │   ├── _animation_engine.dart
│   │   ├── animation_base_engine.dart
│   │   ├── engine_configs.dart
│   │   ├── fallback_engine.dart
│   │   └── platform_based_engines
│   │       ├── _engine_mapper_x.dart
│   │       ├── android_animation_engine.dart
│   │       └── ios_animation_engine.dart
│   ├── animation_wrapper
│   │   ├── animated_overlay_shell.dart
│   │   ├── animated_overlay_wrapper.dart
│   │   └── overlay_animation_x_for_widget.dart
│   └── animation.md
└── widget_animation_x.dart
```

---

## 🔁 Core Flow

### 1. Request comes in (e.g., `context.showAppDialog()`)

### 2. `getEngine(OverlayCategory)` returns an `AnimationEngine`

- Based on `TargetPlatform` and `OverlayCategory`
- iOS: `IOSOverlayAnimationEngine`
- Android: `AndroidOverlayAnimationEngine`

### 3. The resolved `engine` is passed into `AnimatedOverlayWrapper`

- Initializes controller
- Plays animation
- Reverses after delay (if configured)

### 4. The overlay widget is injected via `builder(engine)`

- Animations can be used with `.opacity`, `.scale`, `.slide`

---

## 🧠 Engine Types

### ✅ Shared Engine (Modern)

- `IOSOverlayAnimationEngine(ShowAs type)`
- `AndroidOverlayAnimationEngine(ShowAs type)`
- Logic is driven by `*OverlayAnimationConfig`

### 🛑 Fallback

- `FallbackAnimationEngine` returns `kAlwaysCompleteAnimation`
- Used as a safety fallback

---

## ⚙️ How to Modify or Extend

### ➕ Add a new animation behavior

1. Extend (if needed) the `ShowAs` (enum for overlays categorizations):

   ```dart
   enum ShowAs { dialog, banner, snackbar, toast, ... }
   ```

2. Add config to iOS or Android engine:

   ```dart
   ShowAs.toast => const AndroidOverlayAnimationConfig(...)
   ```

3. Use `.getEngine(OverlayCategory)` to auto-inject.

---

### 🧱 How to Customize Animations

- Modify values in `IOSOverlayAnimationConfig` or `AndroidOverlayAnimationConfig`
- For example:

  ```dart
  IOSOverlayAnimationConfig(
    duration: Duration(milliseconds: 700),
    opacityCurve: Curves.easeIn,
    scaleBegin: 0.85,
    ...
  );
  ```

---

### 🧼 How to Inject Dismiss Logic

```dart
AnimatedOverlayWrapper(
  engine: ...,
  displayDuration: Duration.zero,
  builder: (_) => widget,
).withDispatcherOverlayControl(onDismiss: () { ... });
```

---

## 🏆 Key Advantages

- ✅ Clean Architecture + SOLID principles
- ✅ Minimal boilerplate for new overlay types
- ✅ High reusability via config pattern
- ✅ Native feel via platform-specific animations
- ✅ Fully testable & decoupled

---

## 🛠️ Useful APIs

### `OverlayEngineX`

```dart
final engine = context.getEngine(OverlayCategory.dialog);
```

### `AnimatedOverlayWrapper`

```dart
AnimatedOverlayWrapper(
  engine: engine,
  displayDuration: Duration(seconds: 3),
  builder: (engine) => YourOverlayWidget(...),
)
```

---

## 🎬 WidgetAnimationX: Declarative Widget Animations

In addition to overlay-level animations, this module provides the `WidgetAnimationX` extension — a set of animation helpers you can apply to any widget for local entrance/exit effects.

**Supported animations:**

- `.fadeIn()` — Opacity fade-in
- `.scaleIn()` — Elastic scale-in
- `.slideInFromBottom()` — Slide up from bottom
- `.slideInFromLeft()` — Slide in from left
- `.rotateIn()` — Rotate in
- `.bounceIn()` — Bouncy scale-in
- `.withAnimatedSwitcherSize()` — Combines AnimatedSwitcher + AnimatedSize for smooth transitions
- `.withSimpleSwitcher()` — Simple AnimatedSwitcher with fade & scale

**Example usage:**

```dart
import 'package:firebase_with_riverpod/core/base_modules/animation/widget_animation_x.dart';

// Basic usage: fade-in
yourWidget.fadeIn(duration: Duration(milliseconds: 350));

// In context, e.g. for animated button label or loader
(isLoading
  ? AppLoader(...)
  : TextWidget(...))
    .withAnimatedSwitcherSize(),
```

**CustomFilledButton Example:**

```dart
class CustomFilledButton extends StatelessWidget {
  ...
  @override
  Widget build(BuildContext context) {
    ...
    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: 'filled_button',
        child: FilledButton(
          onPressed: (isEnabled && !isLoading) ? onPressed : null,
          child:
              (isLoading
                ? AppLoader(...)
                : TextWidget(...))
              .withAnimatedSwitcherSize(),
        ),
      ),
    );
  }
}
```

**Tip:** You can combine multiple animations for more complex effects:

```dart
Text('Hello').fadeIn().scaleIn();
```

Widget-level animations are lightweight, stateless, and work with any widget tree.

---

---

## 🔒 Fallback & Safety

- `FallbackAnimationEngine` avoids crashes if config fails.
- Good for production fallback behavior.
- Suggestion: track `_isActive` for debug logging.

---

## ✅ Final Notes

- iOS and Android engines are fully modular
- Easy to extend, replace or test
- One place to control animation logic (via `*Config`)
- Add new platforms or behaviors in isolated files

---

For best practices: keep configs immutable and avoid hardcoding in engine logic.

> Build fast, clean, native-feeling overlays with full animation lifecycle control.
