# 🕷️ Spider Setup Manual for Flutter Assets

## 📦 Installation

### ✅ Using Dart (recommended)

```bash
dart pub global activate spider
```

### 💻 Using Homebrew (macOS only)

```bash
brew tap birjuvachhani/spider
brew install spider
```

---

## 📁 Configuration

### Create a configuration file in custom directory (recommended):

```bash
spider create -p ./lib/core/app_config/spider
```

This creates: `lib/core/app_config/spider/spider.yaml`

### Sample `spider.yaml`

```yaml
# Spider config

generate_tests: false
no_comments: true
export: true
use_part_of: false

package: core/app_config/spider

groups:
  - path: assets/images
    class_name: AppImages
    types: [.png, .jpg, .jpeg, .webp, .gif]
    output: lib/core/app_config/spider/app_images.dart
```

---

## 🛠️ Build

### Run build manually:

```bash
spider -p ./lib/core/app_config/spider/spider.yaml build
```

### Optional: Watch for file changes

```bash
spider -p ./lib/core/app_config/spider/spider.yaml build --watch
```

---

## 🔍 Usage in Dart Code

```dart
import 'package:core/app_config/spider/app_images.dart';

Image.asset(AppImages.error);
```

---

## ⚠️ Notes

* `spider.yaml` **must** be passed via `-p` flag if stored outside root.
* Localization is **not** supported by Spider. Use `easy_localization` instead.

---

## 📚 Resources

* [Spider on pub.dev](https://pub.dev/packages/spider)
* [Installation Guide](https://pub.dev/packages/spider/install)
* [Documentation](https://birjuvachhani.github.io/spider)
