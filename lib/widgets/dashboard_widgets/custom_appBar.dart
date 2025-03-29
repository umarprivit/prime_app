import 'package:flutter/material.dart';
import 'package:prime_app/config/config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey[200],
      backgroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleSpacing: 10,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.teal, size: 31),
        onPressed: () {
          // Handle menu action
          // opne drwaer
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text("Welcome Back!",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            fontFamily: Config.FONT_FAMILY,
          )),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle, color: Colors.teal, size: 36),
          onPressed: () {
            // Handle profile action
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
