part of 'current_theme.dart';

///Contains the theme [Color] and [Gradient] for both light and dark themes
class ThemeStyle {
  late final Color primaryColor;
  late final Color mainColor;
  late final Color secondaryColor;
  late final Color primaryColorOnPrimary;
  late final Color secondaryColorOnSecondary;
  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color evenDarkColor;
  late final Color evenLightColor;

  ThemeStyle({required bool isLight}) {
    primaryColor = isLight ? hexToColor('#191C32') : hexToColor('#F3F5F6');

    secondaryColor = isLight ? hexToColor('#F3F5F6') : hexToColor('#191C32');

    mainColor = isLight ? hexToColor("#2D60FF") : hexToColor("#2D60FF");

    secondaryColorOnSecondary =
        isLight ? hexToColor("#9395A4") : hexToColor("#9395A4");

    primaryTextColor = isLight ? hexToColor("#000000") : hexToColor("#FFFFFF");
    secondaryTextColor =
        isLight ? hexToColor("#FFFFFF") : hexToColor("#000000");
    primaryColorOnPrimary =
        isLight ? hexToColor("#FFFFFF") : hexToColor("#FFFFFF");

    evenDarkColor = isLight ? hexToColor("#191C32") : hexToColor("#191C32");
    evenLightColor = isLight ? hexToColor("#FFFFFF") : hexToColor("#FFFFFF");
  }

  static Color hexToColor(String hexString) {
    hexString = hexString.replaceFirst('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
