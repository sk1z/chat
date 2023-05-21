import 'package:flutter/material.dart';
import 'package:chat/styles/styles.dart';

enum ItemTileMode { standard, accent }

class ItemTile extends StatelessWidget {
  const ItemTile({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.mode = ItemTileMode.standard,
    this.divider = false,
  });

  final Icon? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final ItemTileMode mode;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    final ItemTileStyle style = Theme.of(context).extension<ItemTileStyle>()!;

    final double? iconWidth;
    final IconThemeData? iconTheme;
    final TextStyle? titleStyle;

    switch (mode) {
      case ItemTileMode.standard:
        iconWidth = style.iconWidth;
        iconTheme = style.iconTheme;
        titleStyle = style.titleStyle;
        break;
      case ItemTileMode.accent:
        iconWidth = style.accentIconWidth ?? style.iconWidth;
        iconTheme = style.iconTheme?.merge(style.accentIconTheme) ??
            style.accentIconTheme;
        titleStyle = style.titleStyle?.merge(style.accentTitleStyle) ??
            style.accentTitleStyle;
        break;
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: subtitle != null ? style.heightWithSubtitle : style.height,
        child: Stack(
          children: [
            Padding(
              padding: style.contentPadding ?? EdgeInsets.zero,
              child: Row(
                children: [
                  if (icon != null)
                    Container(
                      alignment: Alignment.centerLeft,
                      width: iconWidth,
                      child: Container(
                        width: iconTheme?.size ?? 24,
                        alignment: Alignment.center,
                        child: IconTheme(
                          data: iconTheme ?? const IconThemeData(),
                          child: icon!,
                        ),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: subtitle == null
                            ? style.titleHeight
                            : style.titleHeightWithSubtitle,
                        child: Text(title, style: titleStyle),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: style.subtitlePadding ?? 0),
                          child: Text(subtitle!, style: style.subtitleStyle),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (divider)
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(left: style.dividerIndent ?? 0),
                child: Container(
                  color: style.dividerColor,
                  height: style.dividerHeight,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
