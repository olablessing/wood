import 'package:flutter/material.dart';

const primaryColor = Color(0xFF38C557);
const backgroundColor = Colors.white;
const accentColor = Colors.redAccent;
const headerTextColor = Color.fromRGBO(0, 0, 0, 0.8);

const bodyTextColor = Color.fromRGBO(0, 0, 0, 0.7);
const fadedColor = Color.fromRGBO(0, 0, 0, 0.3);
const green = Color(0xFF40E5BF);
const grey = Color(0xFFF0F0EF);
const red = Color(0xFFEE3333);
const oronge = Colors.orange;

const error = red;
const success = green;

class CustomTheme {
  ThemeData get lightTheme {
    //1
    return baseTheme().copyWith(
      cardColor: Colors.white,
      primaryColor: primaryColor,
      backgroundColor: Colors.white,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
      scaffoldBackgroundColor: Color(0XFFFAFAFA),
    );
  }

  ThemeData get darkTheme {
    return baseTheme().copyWith(
      cardColor: Colors.grey[800],
      backgroundColor: Colors.grey[800],
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }

  ThemeData baseTheme() {
    return ThemeData(
        //2
        fontFamily: "Roboto",
        primaryColor: primaryColor,
        accentColor: Colors.redAccent,
        splashColor: Colors.grey[100],
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryColor,
        ),
        colorScheme: const ColorScheme.light(primary: primaryColor),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        buttonBarTheme:
            const ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.primary));
  }

  ThemeData buildLightTheme() {
    final ThemeData base = baseTheme();
    return base.copyWith(
      cardColor: Colors.white,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
    );
  }

  ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      cardColor: Colors.grey[800],
      backgroundColor: Colors.grey[800],
      scaffoldBackgroundColor: Colors.grey[900],
    );
  }
}

// Styles
ButtonStyle baseButtonStyle() {
  return ButtonStyle(
      // overlayColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) => states.contains(MaterialState.disabled)
            ? Colors.grey
            : primaryColor,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
}

ButtonStyle flatTextButtonStyle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
    foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
  );
}

ButtonStyle outlinedButtonStyle() {
  return ButtonStyle(
      // overlayColor: MaterialStateProperty.all<Color>(Colors.redAccent),
      padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
      foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: primaryColor, width: 1))));
}

// ButtonStyle flatTextButtonStyle() {
//   return ButtonStyle(
//     padding: MaterialStateProperty.all<EdgeInsets>(
//         EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
//     foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
//     backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
//   );
// }

// TextField Styles
InputDecoration outlinedTextFields(BuildContext context) {
  return InputDecoration(
      filled: true,
      labelStyle:
          Theme.of(context).textTheme.bodyText2!.copyWith(color: fadedColor),
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(width: 0)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 0.8, color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide:
              BorderSide(width: 0.8, color: Theme.of(context).errorColor)),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: Colors.transparent)));
}

TextStyle formfFieldLabelStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .caption!
      .copyWith(color: bodyTextColor, fontWeight: FontWeight.w400);
}

TextStyle applicationFormHeaderStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .subtitle1!
      .copyWith(color: primaryColor, fontWeight: FontWeight.w500);
}

TextStyle scaffoldTitleStyle(BuildContext context) {
  return Theme.of(context).textTheme.headline6!.copyWith();
}

TextStyle loanListTileTitleStyle(BuildContext context) {
  return Theme.of(context)
      .textTheme
      .bodyText1!
      .copyWith(fontWeight: FontWeight.w500, color: headerTextColor);
}
