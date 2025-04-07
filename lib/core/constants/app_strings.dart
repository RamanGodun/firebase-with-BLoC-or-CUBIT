/// 📄 **AppStrings** — Centralized place for all app text constants.
/// Improves maintainability and localization readiness.
abstract class AppStrings {
  ///
  // ===============================
  // 🏠 App Titles
  // ===============================

  static const String appTitle = 'Firebase with BLoC/Cubit';
  static const String toggleTheme = 'Toggle Theme';

  ///
  // ===============================
  // 🌍 Fatal Game Texts
  // ===============================

  static const String pageTitle = '🌍 The World Depends on You!';
  static const String criticalDifference = '⚠ Critical Difference: ';
  static const String noDifference =
      "Now is no difference, what the difference...";
  static const String firstCoreLabel = '💥 First Core Value:  ';
  static const String secondCoreLabel = '🌀 Primary Core Value:  ';
  static const String incrementButtonText = '🔼 Increase Core Power (+5)';
  static const String decrementButtonText = '🔽 Decrease Counterforce (-5)';
  static const String restartButtonText = '🔄 Next time I\'ll stop, for sure';

 

  ///
  // ===============================
  // 📱 Basic StateProvider Page
  // ===============================

  static const String basicStatePage =
      'On this page using Basic State Provider.';
  static const String basicStateInstruction =
      'You are just amazing 🤩, you\'ve already clicked:';

  ///
  // ===============================
  // 🟢 Counter Screen Texts
  // ===============================

  static const String counterScreenTitle =
      'This page using State Provider with AutoDisposed mode';
  static const String counterInstruction =
      'Dude, nice 😎, you\'ve already clicked:';
  static const String clickSingular = 'time';
  static const String clickPlural = 'times';

  static const Map<int, String> counterWarningMessages = {
    2: "Whoa! You've clicked 2 times! Easy there, champ! 🏆",
    4: "Okay, 4 clicks... are you trying to break something?! 🤨",
    5: "🚨 ALERT! 5 clicks detected! Authorities have been notified! 🚔😂",
  };

  // ────────────────────────────────────────────────────────────────────
  // 🏠 **Titles**
  // ────────────────────────────────────────────────────────────────────
  static const String homePageTitle = 'Home Page';

  /// 🔄 **State Shape Titles**
  static const String titleForListenerBasedStateShape = '  todos left (LB SP)';
  static const String titleForStreamSubscriptionStateShape =
      '  todos left (SSB SP)';

  // ────────────────────────────────────────────────────────────────────
  // 🆗 **Buttons**
  // ────────────────────────────────────────────────────────────────────
  static const String okButton = 'OK';
  static const String cancelButton = 'Cancel';
  static const String addButton = 'ADD';
  static const String editButton = 'Edit';
  static const String deleteButton = 'Delete';
  static const String saveButton = 'Save';

  // ────────────────────────────────────────────────────────────────────
  // 🌗 **Theme Mode Messages**
  // ────────────────────────────────────────────────────────────────────
  static const String lightModeEnabled = 'now is  "Light Mode"';
  static const String darkModeEnabled = 'now is  "Dark Mode"';

  // ────────────────────────────────────────────────────────────────────
  // 🔄 **State Propagation Messages**
  // ────────────────────────────────────────────────────────────────────
  static const String statePropagationLSS =
      'State Propagation:             "Listener-Based"';
  static const String statePropagationSSS =
      'State Propagation:              "Stream Subscription"';

  // ────────────────────────────────────────────────────────────────────
  // 🔍 **Search Bar**
  // ────────────────────────────────────────────────────────────────────
  static const String searchTodosLabel = 'Search todos...';

  // ────────────────────────────────────────────────────────────────────
  // 🏷️ **Filters**
  // ────────────────────────────────────────────────────────────────────
  static const String filterAll = 'All';
  static const String filterActive = 'Active';
  static const String filterCompleted = 'Completed';

  // ────────────────────────────────────────────────────────────────────
  // 📝 **Create ToDo Dialog**
  // ────────────────────────────────────────────────────────────────────
  static const String newTodoTitle = 'New ToDo';
  static const String todoInputHint = 'What to do?';

  // ────────────────────────────────────────────────────────────────────
  // ✏️ **Edit ToDo Dialog**
  // ────────────────────────────────────────────────────────────────────
  static const String editTodoTitle = 'Edit ToDo';
  static const String newTodoDescription = 'New description';
}
