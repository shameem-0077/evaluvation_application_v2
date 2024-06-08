import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subTitle;
  final Function? onTap;
  final Function? onLongPress;
  final Function? onDoubleTap;
  final Widget? trailing;
  final Color? tileColor;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.subTitle,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.tileColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tileColor,
      child: onTap != null ? buildInkWell() : buildContent(),
    );
  }

  Widget buildInkWell() {
    return InkWell(
      onTap: onTap as void Function()?,
      onLongPress: onLongPress as void Function()?,
      onDoubleTap: onDoubleTap as void Function()?,
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: leading,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title ?? const SizedBox(),
                const SizedBox(height: 10),
                subTitle ?? const SizedBox(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: trailing,
          )
        ],
      ),
    );
  }
}
