// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _pl = {
  "app": {
    "title": "Firebase z BLoC/Cubit"
  },
  "buttons": {
    "ok": "OK",
    "cancel": "Anuluj",
    "sign_in": "Zaloguj się",
    "sign_up": "Zarejestruj się",
    "submit_tag": "Wyślij",
    "to_sign_in": "Masz już konto? Zaloguj się!",
    "to_sign_up": "Nie masz konta? Zarejestruj się!"
  },
  "errors": {
    "unexpected": "Coś poszło nie tak",
    "errors_general_title": "Wystąpił błąd",
    "no_internet": "Brak połączenia z internetem",
    "network": {
      "no_connection": "Brak połączenia z internetem",
      "timeout": "Upłynął limit czasu połączenia. Spróbuj później."
    },
    "auth": {
      "unauthorized": "Nie jesteś zalogowany. Zaloguj się."
    },
    "firebase": {
      "generic": "Wystąpił błąd Firebase. Spróbuj ponownie."
    },
    "format": {
      "error": "Nieprawidłowy format danych."
    },
    "unknown": "Wystąpił nieznany błąd.",
    "plugin": {
      "missing": "Wymagany plugin jest brakujący lub nie został zainicjalizowany."
    },
    "timeout": "Przekroczono limit czasu. Spróbuj ponownie."
  },
  "failure": {
    "firebase": {
      "doc_missing": "Brak profilu użytkownika.",
      "wrong_password": "Nieprawidłowe hasło.",
      "user_not_found": "Użytkownik nie został znaleziony.",
      "invalid_credential": "Nieprawidłowe dane logowania. Sprawdź poprawność i spróbuj ponownie.",
      "generic": "Wystąpił błąd Firebase.",
      "email_in_use": "Ten adres e-mail jest już używany.",
      "invalid_email": "Nieprawidłowy format adresu e-mail.",
      "missing_email": "Brak pola e-mail.",
      "no_current_user": "Brak aktualnie zalogowanego użytkownika.",
      "operation_not_allowed": "Ta operacja nie jest dozwolona przez Firebase.",
      "requires_recent_login": "Aby kontynuować, musisz się ponownie zalogować.",
      "too_many_requests": "Zbyt wiele prób. Spróbuj ponownie później.",
      "user_disabled": "To konto zostało dezaktywowane.",
      "weak_password": "Hasło jest zbyt słabe."
    },
    "format": {
      "error": "Odebrano nieprawidłowy format danych."
    },
    "network": {
      "no_connection": "Brak połączenia z Internetem.",
      "timeout": "Limit czasu połączenia został przekroczony. Spróbuj ponownie później."
    },
    "auth": {
      "unauthorized": "Twoja sesja wygasła. Zaloguj się ponownie."
    },
    "plugin": {
      "missing": "Wykryto brakujący plugin. Skontaktuj się z pomocą techniczną."
    },
    "unknown": "Wystąpił nieoczekiwany błąd. Spróbuj ponownie."
  },
  "form": {
    "name": "Imię",
    "name_is_empty": "pole nie może być puste",
    "name_is_too_short": "musi mieć co najmniej 3 znaki",
    "email": "Email",
    "email_is_empty": "nie może być puste",
    "email_is_invalid": "nieprawidłowy format emaila",
    "password": "Hasło",
    "password_required": "wymagane jest hasło",
    "password_too_short": "musi mieć co najmniej 6 znaków",
    "confirm_password": "Potwierdź hasło",
    "confirm_password_is_empty": "musisz ponownie wprowadzić hasło",
    "confirm_password_mismatch": "hasła nie są zgodne"
  },
  "info": {
    "bloc_slogan": "Bloc to świetna biblioteka zarządzania stanem dla Fluttera!"
  },
  "languages": {
    "switched_to_pl": "Język zmieniony na 🇵🇱 Polski",
    "switched_to_en": "Język zmieniony na 🇬🇧 Angielski",
    "switched_to_ua": "Język zmieniony na 🇺🇦 Ukraiński"
  },
  "overlays": {
    "success": {
      "saved": "Zapisano pomyślnie",
      "deleted": "Element został usunięty"
    }
  },
  "pages": {
    "change_password": "Zmień hasło",
    "error_dialog": "Wystąpił błąd",
    "go_to_home": "Na stronę główną",
    "home": "     Strona główna",
    "not_found_message": "Ups! Strona, której szukasz, nie istnieje.",
    "not_found_title": "Nie znaleziono strony",
    "profile": "Profil",
    "reset_password": "Zresetuj hasło",
    "verify_email": "Zweryfikuj email"
  },
  "profile": {
    "name": "👤 Imię:       ",
    "id": "🆔 ID:           ",
    "email": "📧 Email:     ",
    "points": "📊 Punkty:   ",
    "rank": "🏆 Ranga:    ",
    "error": "Ups!\nCoś poszło nie tak."
  },
  "routes": {
    "home": "/home"
  },
  "theme": {
    "light_enabled": "Obecnie \"Tryb jasny\"",
    "dark_enabled": "Obecnie \"Tryb ciemny\"",
    "amoled_enabled": "Obecnie  \"Amoled Tryb\"",
    "light": "Motyw jasny",
    "dark": "Motyw ciemny",
    "amoled": "Motyw AMOLED",
    "choose_theme": "Wybierz motyw"
  }
};
static const Map<String,dynamic> _uk = {
  "app": {
    "title": "Firebase з BLoC/Cubit"
  },
  "buttons": {
    "ok": "ОК",
    "cancel": "Скасувати",
    "sign_in": "Увійти",
    "sign_up": "Зареєструватися",
    "submit_tag": "Відправити",
    "to_sign_in": "Вже маєте акаунт?  Увійдіть!",
    "to_sign_up": "Ще не маєте акаунта?  Зареєструйтесь!"
  },
  "errors": {
    "unexpected": "Щось пішло не так",
    "errors_general_title": "Виникла помилка",
    "no_internet": "Немає підключення до інтернету",
    "network": {
      "no_connection": "Немає підключення до інтернету",
      "timeout": "Час з'єднання вичерпано. Спробуйте пізніше."
    },
    "auth": {
      "unauthorized": "Ви не авторизовані. Будь ласка, увійдіть."
    },
    "firebase": {
      "generic": "Сталася помилка Firebase. Спробуйте ще раз."
    },
    "format": {
      "error": "Невірний формат даних."
    },
    "unknown": "Сталася невідома помилка.",
    "plugin": {
      "missing": "Потрібний плагін відсутній або не ініціалізований."
    },
    "timeout": "Час очікування минув. Спробуйте ще раз."
  },
  "failure": {
    "firebase": {
      "doc_missing": "Профіль користувача відсутній.",
      "wrong_password": "Неправильний пароль.",
      "user_not_found": "Користувача не знайдено.",
      "invalid_credential": "Некоректні облікові дані. Будь ласка, перевірте введене і спробуйте ще раз.",
      "generic": "Сталася помилка Firebase.",
      "email_in_use": "Ця електронна адреса вже використовується.",
      "invalid_email": "Некоректний формат електронної пошти.",
      "missing_email": "Поле електронної пошти відсутнє.",
      "no_current_user": "Немає поточного авторизованого користувача.",
      "operation_not_allowed": "Цю дію заборонено налаштуваннями Firebase.",
      "requires_recent_login": "Для виконання цієї дії потрібно нещодавно увійти до системи.",
      "too_many_requests": "Забагато запитів. Спробуйте пізніше.",
      "user_disabled": "Обліковий запис деактивовано.",
      "weak_password": "Пароль занадто слабкий."
    },
    "format": {
      "error": "Отримано некоректний формат даних."
    },
    "network": {
      "no_connection": "Немає підключення до Інтернету.",
      "timeout": "Час очікування перевищено. Спробуйте пізніше."
    },
    "auth": {
      "unauthorized": "Сесію завершено. Увійдіть знову."
    },
    "plugin": {
      "missing": "Виявлено відсутній плагін. Зверніться до служби підтримки."
    },
    "unknown": "Сталася непередбачувана помилка. Спробуйте пізніше."
  },
  "form": {
    "name": "Ім'я",
    "name_is_empty": "поле не може бути пустим",
    "name_is_too_short": "щонайменше має бути три символи",
    "email": "Електронна пошта",
    "email_is_empty": "не може бути пустою",
    "email_is_invalid": "некоректний формат",
    "password": "Пароль",
    "password_required": "потрібно вести пароль",
    "password_too_short": "має бути щонайменше 6 символів",
    "confirm_password": "Підтвердження паролю",
    "confirm_password_is_empty": "необхідно ще раз ввести пароль",
    "confirm_password_mismatch": "паролі не співпадають"
  },
  "info": {
    "bloc_slogan": "Bloc — це чудова бібліотека управління станом для Flutter!"
  },
  "languages": {
    "switched_to_pl": "Мову змінено на 🇵🇱 Польську",
    "switched_to_en": "Мову змінено на 🇬🇧 Англійську",
    "switched_to_ua": "Мову змінено на 🇺🇦 Українську"
  },
  "overlays": {
    "success": {
      "saved": "Успішно збережено",
      "deleted": "Елемент видалено"
    }
  },
  "pages": {
    "change_password": "Змінити пароль",
    "error_dialog": "Сталася помилка",
    "go_to_home": "На головну",
    "home": "     Головна сторінка",
    "not_found_message": "Ой! Сторінку, яку ви шукаєте, не знайдено.",
    "not_found_title": "Сторінку не знайдено",
    "profile": "Профіль",
    "reset_password": "Скинути пароль",
    "verify_email": "Підтвердити пошту"
  },
  "profile": {
    "name": "👤 Ім'я:       ",
    "id": "🆔 ID:          ",
    "email": "📧 Пошта:  ",
    "points": "📊 Бали:     ",
    "rank": "🏆 Ранг:      ",
    "error": "Ой!\nЩось пішло не так."
  },
  "routes": {
    "home": "/home"
  },
  "theme": {
    "light_enabled": "Зараз увімкнено \"Світлу тему\"",
    "dark_enabled": "Зараз увімкнено \"Темну тему\"",
    "amoled_enabled": "Зараз увімкнено  \"Амолед тему\"",
    "light": "Світла тема",
    "dark": "Темна тема",
    "amoled": "AMOLED тема",
    "choose_theme": "Оберіть тему"
  }
};
static const Map<String,dynamic> _en = {
  "app": {
    "title": "Firebase with BLoC/Cubit"
  },
  "buttons": {
    "ok": "OK",
    "cancel": "Cancel",
    "sign_in": "Sign In",
    "sign_up": "Sign Up",
    "submit_tag": "Submit",
    "to_sign_in": "Already a member? Sign In!",
    "to_sign_up": "Not a member? Sign Up!"
  },
  "errors": {
    "unexpected": "Something went wrong",
    "errors_general_title": "An error occurred",
    "no_internet": "No internet connection",
    "network": {
      "no_connection": "No internet connection",
      "timeout": "The connection timed out. Please try again later."
    },
    "auth": {
      "unauthorized": "You are not authorized. Please log in."
    },
    "firebase": {
      "generic": "A Firebase error occurred. Please try again."
    },
    "format": {
      "error": "Invalid data format."
    },
    "unknown": "An unknown error occurred.",
    "plugin": {
      "missing": "A required plugin is missing or not initialized."
    },
    "timeout": "Request timeout. Try again."
  },
  "failure": {
    "firebase": {
      "doc_missing": "User profile is missing.",
      "wrong_password": "Wrong password.",
      "user_not_found": "User not found.",
      "invalid_credential": "Invalid credentials. Please check your input and try again.",
      "generic": "A Firebase error occurred.",
      "email_in_use": "Email is already in use.",
      "invalid_email": "Invalid email format.",
      "missing_email": "Missing email field.",
      "no_current_user": "No current user signed in.",
      "operation_not_allowed": "Operation not allowed by Firebase.",
      "requires_recent_login": "Please reauthenticate to continue.",
      "too_many_requests": "Too many attempts. Please try again later.",
      "user_disabled": "This account is disabled.",
      "weak_password": "Password is too weak."
    },
    "format": {
      "error": "Invalid data format received."
    },
    "network": {
      "no_connection": "No internet connection.",
      "timeout": "Connection timed out. Please try again later."
    },
    "auth": {
      "unauthorized": "Your session has expired. Please sign in again."
    },
    "plugin": {
      "missing": "Missing plugin detected. Please contact support."
    },
    "unknown": "An unexpected error occurred. Please try again."
  },
  "form": {
    "name": "Name",
    "name_is_empty": "field cannot be empty",
    "name_is_too_short": "must be at least 3 characters",
    "email": "Email",
    "email_is_empty": "cannot be empty",
    "email_is_invalid": "invalid email format",
    "password": "Password",
    "password_required": "password is required",
    "password_too_short": "must be at least 6 characters",
    "confirm_password": "Confirm Password",
    "confirm_password_is_empty": "need to re-enter the password",
    "confirm_password_mismatch": "passwords do not match"
  },
  "info": {
    "bloc_slogan": "Bloc is an awesome state management library for Flutter!"
  },
  "languages": {
    "switched_to_pl": "Language switched to 🇵🇱 Polish",
    "switched_to_en": "Language switched to 🇬🇧 English",
    "switched_to_ua": "Language switched to 🇺🇦 Ukrainian"
  },
  "overlays": {
    "success": {
      "saved": "Saved successfully",
      "deleted": "Item deleted"
    }
  },
  "pages": {
    "change_password": "Change Password",
    "error_dialog": "Error occurs",
    "go_to_home": "To Home Page",
    "home": "     Home Page",
    "not_found_message": "Oops! The page you’re looking for does not exist.",
    "not_found_title": "Page Not Found",
    "profile": "Profile",
    "reset_password": "Reset Password",
    "verify_email": "Verify Email"
  },
  "profile": {
    "name": "👤 Name:   ",
    "id": "🆔 ID:         ",
    "email": "📧 Email:    ",
    "points": "📊 Points:  ",
    "rank": "🏆 Rank:    ",
    "error": "Oops!\nSomething went wrong."
  },
  "routes": {
    "home": "/home"
  },
  "theme": {
    "light_enabled": "now is  \"Light Mode\"",
    "dark_enabled": "now is  \"Dark Mode\"",
    "amoled_enabled": "now is  \"Amoled Mode\"",
    "light": "Light theme",
    "dark": "Dark theme ",
    "amoled": "Amoled theme",
    "choose_theme": "Choose theme"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"pl": _pl, "uk": _uk, "en": _en};
}
