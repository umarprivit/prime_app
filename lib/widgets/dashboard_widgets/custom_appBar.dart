import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey[200],
      backgroundColor: Colors.white,
      elevation: 2,
      titleSpacing: 10,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.teal, size: 31),
        onPressed: () {
          // Handle menu action
          // opne drwaer
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            Icon(Icons.search, color: Colors.teal),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
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
