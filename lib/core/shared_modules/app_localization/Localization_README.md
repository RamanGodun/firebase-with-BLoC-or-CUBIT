flutter pub run easy_localization:generate \
  -S assets/translations \
  -O lib/core/shared_modules/app_localization/generated \
  -o codegen_loader.g.dart


flutter pub run easy_localization:generate \
  -f keys \
  -S assets/translations \
  -O lib/core/shared_modules/app_localization/generated \
  -o locale_keys.g.dart

