import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'styles/styles.dart';

ThemeData get theme => kDebugMode ? _createTheme : _releaseTheme;

final _releaseTheme = _createTheme;

ThemeData get _createTheme {
  return ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
      headlineLarge: TextStyle(),
      headlineMedium: TextStyle(),
      headlineSmall: TextStyle(),
      titleLarge: TextStyle(),
      titleMedium: TextStyle(),
      titleSmall: TextStyle(),
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      bodySmall: TextStyle(),
      labelLarge: TextStyle(),
      labelMedium: TextStyle(),
      labelSmall: TextStyle(),
    ).apply(bodyColor: Colors.white),
    primaryColorDark: const Color(0xff0097A7),
    primaryColorLight: const Color(0xffB2EBF2),
    colorScheme: const ColorScheme.light(secondary: Color(0xff009688)),
    scaffoldBackgroundColor: const Color(0xff151e27),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Color(0xff424850),
      selectionHandleColor: Color(0xff419fe8),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff212d3b),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff1c222e)),
    iconTheme: const IconThemeData(color: Colors.white70),
    highlightColor: const Color(0x952E3D4E),
    splashColor: const Color(0xff394a5e),
    cardColor: const Color(0xff293849),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xff5fa3de),
      foregroundColor: Colors.white,
      disabledElevation: 0,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
    extensions: [
      const LoginPageStyle(
        backgroundColor: Color(0xff1d2733),
      ),
      const LoginFormStyle(
        alignment: Alignment(0, -1 / 3),
        padding: EdgeInsets.symmetric(vertical: 4),
        logoPadding: EdgeInsets.only(
          top: 4,
          bottom: 12,
        ),
        logoHeight: 120,
      ),
      LoginButtonStyle(
        padding: const EdgeInsets.symmetric(vertical: 4),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color(0xffffd600),
        ),
      ),
      GoogleLoginButtonStyle(
        padding: const EdgeInsets.symmetric(vertical: 4),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color(0xff009688),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
      ),
      const SignUpTextButtonStyle(
        textStyle: TextStyle(color: Color(0xff00BCD4)),
      ),
      const SignUpPageStyle(
        backgroundColor: Color(0xff1d2733),
      ),
      const SignUpFormStyle(
        alignment: Alignment(0, -1 / 3),
        padding: EdgeInsets.symmetric(vertical: 4),
      ),
      SignUpButtonStyle(
        padding: const EdgeInsets.symmetric(vertical: 4),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.orangeAccent,
        ),
      ),
      LoginDataInputStyle(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff485b6f)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff6eb2ef), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(color: Color(0xff7d8b99)),
        ),
      ),
      const ProfileCreationPageStyle(
        backgroundColor: Color(0xff1d2733),
      ),
      const ProfileCreationFormStyle(
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      const ProfileCreationSubmitButtonStyle(
        iconTheme: IconThemeData(
          size: 28,
          color: Colors.white,
        ),
      ),
      const ChatTileStyle(
        height: 72.2,
        contentPadding: EdgeInsets.only(
          left: 10,
          right: 15,
        ),
        avatarWidth: 66,
        avatarSize: 54.5,
        avatarColor: Color(0xff549cdd),
        avatarTextStyle: TextStyle(
          fontSize: 19.5,
          fontWeight: FontWeight.w500,
        ),
        nameHeight: 33,
        nameStyle: TextStyle(
          fontSize: 17.5,
          fontWeight: FontWeight.w500,
          color: Color(0xffe9eef4),
        ),
        messagePadding: EdgeInsets.only(bottom: 14.5),
        messageStyle: TextStyle(
          fontSize: 16,
          color: Color(0xff7d8b99),
        ),
        sentTimePadding: EdgeInsets.only(left: 2),
        sentTimeHeight: 31.1,
        sentTimeStyle: TextStyle(
          fontSize: 13.5,
          color: Color(0xff737f8b),
        ),
        dividerPadding: EdgeInsets.only(left: 72),
        dividerHeight: 0.25,
        dividerColor: Color(0xff0c1015),
      ),
      const HeaderStyle(
        height: 40.5,
        titlePadding: EdgeInsets.symmetric(horizontal: 23.7),
        titleHeight: 37.3,
        titleStyle: TextStyle(
          fontSize: 15.5,
          color: Color(0xff79c4fc),
          fontWeight: FontWeight.bold,
        ),
        wideHeight: 52,
        wideTitlePadding: EdgeInsets.symmetric(horizontal: 21.5),
      ),
      const ItemDividerStyle(
        height: 12,
        heightWithTitle: 32,
        titleAlignment: Alignment.centerLeft,
        titlePadding: const EdgeInsets.only(left: 17),
        titleStyle: const TextStyle(
          color: Color(0xff7d8b99),
          fontWeight: FontWeight.bold,
        ),
      ),
      const ContactTileStyle(
        height: 58.1,
        contentPadding: EdgeInsets.symmetric(horizontal: 13.2),
        avatarColor: Color(0xff549cdd),
        avatarWidth: 57.7,
        avatarSize: 46.2,
        avatarTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        nameStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        nameHeight: 28.8,
        lastSeenPadding: EdgeInsets.only(bottom: 8.8),
        lastSeenStyle: TextStyle(
          color: Color(0xff7d8b99),
          fontSize: 14,
        ),
        onlineStyle: TextStyle(
          color: Color(0xff64b5ef),
          fontSize: 14,
        ),
        appBarContentPadding: EdgeInsets.symmetric(horizontal: 8),
        appBarAvatarWidth: 54.5,
        appBarAvatarSize: 42,
        appBarAvatarTextStyle: TextStyle(fontSize: 15),
        appBarNameStyle: TextStyle(fontSize: 17),
        appBarNameHeight: 29.3,
        appBarLastSeenPadding: EdgeInsets.only(bottom: 10.5),
      ),
      const FlipCounterStyle(
        padding: EdgeInsets.symmetric(horizontal: 9),
        mainAxisAlignment: MainAxisAlignment.start,
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      const MessageInputStyle(
        constraints: BoxConstraints(
          minHeight: 50,
          maxHeight: 150,
        ),
        color: Color(0xff212d3b),
        messagePadding: EdgeInsets.only(
          left: 14,
          bottom: 1,
        ),
        messageDecorationTheme: InputDecorationTheme(
          iconColor: Colors.red,
          focusColor: Colors.red,
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: 18,
            color: Color(0xff718190),
          ),
        ),
        cursorColor: Color(0xff54a1db),
        messageStyle: TextStyle(fontSize: 18),
        sendButtonPadding: EdgeInsets.only(bottom: 1),
        sendButtonIconTheme: IconThemeData(
          size: 27,
          color: Color(0xff64b5ef),
        ),
      ),
      const MessageListStyle(
        padding: EdgeInsets.symmetric(vertical: 4),
      ),
      const MessageHighlightStyle(color: Color(0xff1c2e42)),
      const MessageSelectionCheckMarkStyle(
        color: Color(0xff5dc244),
        borderColor: Colors.white,
        size: 20,
        margin: EdgeInsets.only(left: 5),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 15,
        ),
      ),
      const MessageBubbleStyle(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        messageLastUpdatedPadding: EdgeInsets.only(left: 15, right: 5),
        borderRadius: 5,
        myMessageColor: Color(0xff40648c),
        contactMessageColor: Color(0xff202434),
        myMessageHighlightColor: Color(0xff6481a1),
        contactMessageHighlightColor: Color(0xff373c4f),
        messageContentStyle: TextStyle(
          fontSize: 14.5,
          color: Colors.white,
        ),
        myMessageLastUpdateStyle: TextStyle(
            fontSize: 11,
            color: Color(0xff7DA7CB),
            fontWeight: FontWeight.w600),
        contactMessageLastUpdateStyle: TextStyle(
            fontSize: 11,
            color: Color(0xff738291),
            fontWeight: FontWeight.w600),
        maxWidthPercentage: 75,
      ),
      MessageMenuStyle(
        clipBehavior: Clip.antiAlias,
        color: const Color(0xff293849),
        margin: const EdgeInsets.fromLTRB(50, 50, 50, 65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        width: 200,
      ),
      const MessageMenuItemStyle(
        height: 48,
        iconPadding: EdgeInsets.symmetric(horizontal: 19),
        iconTheme: IconThemeData(color: Color(0xff768998)),
        titleStyle: TextStyle(
          color: Colors.white,
          fontSize: 16.5,
        ),
      ),
      const ItemTileStyle(
        height: 50.2,
        heightWithSubtitle: 60.5,
        contentPadding: EdgeInsets.symmetric(horizontal: 22.5),
        iconWidth: 49,
        iconTheme: IconThemeData(
          color: Color(0xff7d8b99),
          size: 24,
        ),
        titleHeight: 33.5,
        titleHeightWithSubtitle: 29.5,
        titleStyle: TextStyle(fontSize: 16),
        subtitlePadding: 10.5,
        subtitleStyle: TextStyle(
          color: Color(0xff79848c),
          fontSize: 12,
        ),
        accentIconWidth: 45,
        accentIconTheme: IconThemeData(
          color: Color(0xff6eb1e3),
          size: 22.5,
        ),
        accentTitleStyle: TextStyle(color: Color(0xff6eb1e3)),
        dividerColor: Color(0xff14141c),
        dividerHeight: 0.35,
        dividerIndent: 20,
      ),
      const FlexibleProfileTileStyle(
        expandedHeight: 144,
        contentPadding: EdgeInsets.only(
          left: 8,
          right: 48,
        ),
        avatarColor: Color(0xff549cdd),
        avatarSize: 42,
        avatarWidth: 54.5,
        avatarTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        nameHeight: 29.3,
        nameStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        onlinePadding: EdgeInsets.only(bottom: 10.5),
        onlineStyle: TextStyle(color: Color(0xff8b97a2)),
        expandedContentPadding: EdgeInsets.only(
          left: 17,
          right: 17,
          top: 42,
        ),
        expandedAvatarWidth: 81,
        expandedAvatarSize: 60,
        expandedAvatarTextStyle: TextStyle(fontSize: 21),
        expandedNameHeight: 52,
        expandedNameStyle: TextStyle(fontSize: 20),
        expandedOnlinePadding: EdgeInsets.only(bottom: 33.5),
      ),
      const ItemBoxStyle(
        color: Color(0xff1d2733),
        elevation: 1,
        shadowColor: Colors.black,
      ),
      const AccountDataInputStyle(
        padding: EdgeInsets.only(
          left: 21.5,
          right: 21.5,
          top: 3.8,
          bottom: 15.8,
        ),
        decorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white60),
          labelStyle: TextStyle(color: Colors.white60),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
      const AccountDataValidatorStyle(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 21.5,
          right: 21.5,
          top: 13.5,
        ),
        errorStyle: TextStyle(
          color: Color(0xffcf5c5f),
          fontSize: 14.5,
        ),
      ),
      const AccountDataHelperStyle(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 21.5,
          right: 21.5,
          top: 11.5,
        ),
        textStyle: TextStyle(
          color: Color(0xff7d8b99),
          fontSize: 14.5,
        ),
      ),
      ProfileEditMenuStyle(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: const Color(0xff293949),
        clipBehavior: Clip.antiAlias,
      ),
      const ProfileEditMenuItemStyle(
        height: 48,
        contentPadding: EdgeInsets.only(
          left: 18.5,
          right: 16.5,
        ),
        iconWidth: 43,
        iconTheme: IconThemeData(
          color: Color(0xff768998),
          size: 24.5,
        ),
        titleStyle: TextStyle(fontSize: 16),
      ),
      const NameEditPageStyle(
        backgroundColor: Color(0xff1d2733),
      ),
      const NameEditFormStyle(
        padding: EdgeInsets.symmetric(vertical: 5),
      ),
      const NameInputStyle(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 21.2,
        ),
        decorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff485b6f)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6eb2ef), width: 2),
          ),
          hintStyle: TextStyle(color: Color(0xff7d8b99)),
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 10.2),
        ),
        textStyle: TextStyle(fontSize: 18),
      ),
    ],
  );
}
