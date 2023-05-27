import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

const double _leftOffset = kToolbarHeight;

class FlexibleProfileTile extends StatelessWidget {
  const FlexibleProfileTile(
      {super.key, required this.firstName, this.lastName});

  final String firstName;
  final String? lastName;

  @override
  Widget build(BuildContext context) {
    final String firstNameFirstLetter =
        firstName.isNotEmpty ? firstName.substring(0, 1) : '';
    final String lastNameFirstLetter = lastName != null && lastName!.isNotEmpty
        ? lastName!.substring(0, 1)
        : '';
    final String nameFirstLetters =
        (firstNameFirstLetter + lastNameFirstLetter).toUpperCase();

    final String name = '$firstName ${lastName ?? ''}';

    final FlexibleProfileTileStyle style =
        Theme.of(context).extension<FlexibleProfileTileStyle>()!;

    final double topOffset = MediaQuery.of(context).viewPadding.top;
    final double collapsedHeight =
        Theme.of(context).appBarTheme.toolbarHeight ??
            _appBar.preferredSize.height;
    final double expandedHeight = style.expandedHeight ?? 150;
    final double heightDifference = expandedHeight - collapsedHeight;

    final EdgeInsetsGeometry? expandedContentPadding =
        style.expandedContentPadding ?? style.contentPadding;
    final double? expandedAvatarWidth =
        style.expandedAvatarWidth ?? style.avatarWidth;
    final double? expandedAvatarSize =
        style.expandedAvatarSize ?? style.avatarSize;
    final TextStyle? expandedAvatarTextStyle =
        style.avatarTextStyle?.merge(style.expandedAvatarTextStyle);
    final double? expandedNameHeight =
        style.expandedNameHeight ?? style.nameHeight;
    final TextStyle? expandedNameStyle =
        style.nameStyle?.merge(style.expandedNameStyle);
    final EdgeInsetsGeometry? expandedOnlinePadding =
        style.expandedOnlinePadding ?? style.onlinePadding;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double expanded =
            (constraints.maxHeight - collapsedHeight - topOffset) /
                heightDifference;

        final EdgeInsetsGeometry contentPadding = EdgeInsets.only(
          left: _leftOffset * (1 - expanded),
          top: topOffset,
        ).add(EdgeInsetsGeometry.lerp(
                style.contentPadding, expandedContentPadding, expanded) ??
            EdgeInsets.zero);
        final double? avatarWidth =
            lerpDouble(style.avatarWidth, expandedAvatarWidth, expanded);
        final double? avatarSize =
            lerpDouble(style.avatarSize, expandedAvatarSize, expanded);
        final TextStyle? avatarTextStyle = TextStyle.lerp(
            style.avatarTextStyle, expandedAvatarTextStyle, expanded);
        final double? nameHeight =
            lerpDouble(style.nameHeight, expandedNameHeight, expanded);
        final TextStyle? nameStyle =
            TextStyle.lerp(style.nameStyle, expandedNameStyle, expanded);
        final EdgeInsetsGeometry? onlinePadding = EdgeInsetsGeometry.lerp(
            style.onlinePadding, expandedOnlinePadding, expanded);

        return Padding(
          padding: contentPadding,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: avatarWidth,
                child: Container(
                  alignment: Alignment.center,
                  width: avatarSize,
                  decoration: BoxDecoration(
                    color: style.avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(nameFirstLetters, style: avatarTextStyle),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: nameHeight,
                    child: Text(name, style: nameStyle),
                  ),
                  Padding(
                    padding: onlinePadding ?? EdgeInsets.zero,
                    child: Text('online', style: style.onlineStyle),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static final AppBar _appBar = AppBar();
}
