part of '_general_extensions.dart';

/// 🎨 [TextStyleX] — Utilities to modify text styles fluently
/// Enables chained style adjustments like size/weight
///----------------------------------------------------------------
extension TextStyleX on TextStyle {
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

/// 🧠 [SemanticTextStyleX] — Maps semantic [TextStyleType] to corresponding style from [TextTheme]
/// Decouples UI text roles from concrete style names (`titleLarge`, etc)
/// Used to maintain consistent typography usage
///----------------------------------------------------------------

extension SemanticTextStyleX on TextTheme {
  TextStyle semantic(TextStyleType type) => switch (type) {
    TextStyleType.heading => titleLarge!,
    TextStyleType.subheading => titleMedium!,
    TextStyleType.body => bodyLarge!,
    TextStyleType.label => labelLarge!,
  };
}

/// 🏷️ [TextStyleType] — Semantic roles for typography usage
/// Helps map use-case (e.g., heading/body) to [TextTheme] values
///----------------------------------------------------------------
enum TextStyleType { heading, subheading, body, label }
