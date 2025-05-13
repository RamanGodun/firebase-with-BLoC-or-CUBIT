import 'presentation/overlay_entries/_overlay_entries.dart';

/// ✅ Type aliases for improved readability in feature and UI layers
/// ❗ Use these in Presentation Layer, not Core Dispatcher logic
//-------------------------------------------------------------
typedef AppSnackbar = SnackbarOverlayEntry;
typedef AppDialog = DialogOverlayEntry;
typedef AppBanner = BannerOverlayEntry;
typedef AppLoader = LoaderOverlayEntry;
typedef AppOverlay = CustomOverlayEntry;
typedef AppKindBanner = ThemedBannerOverlayEntry;
