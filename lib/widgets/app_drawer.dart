import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prime_app/controllers/loginScreen_controller.dart';
import 'package:prime_app/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginscreenController con = Get.put(LoginscreenController());
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back button & Title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(width: 8),
                Text(
                  "MENU",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(Icons.person_outline, "My Profile", () {}),
                _buildDrawerItem(Icons.extension, "MCQs", () {
                  Get.toNamed(Routes.MCQS_SUBJECT_SCREEN_ROUTE);
                }),
                _buildDrawerItem(Icons.download_rounded, "Downloads", () {}),
                _buildDrawerItem(
                    Icons.bug_report_outlined, "Report Bugs", () {}),
                _buildDrawerItem(Icons.help_outline, "Ask a question", () {}),
                _buildDrawerItem(Icons.logout, "Logout", () {
                  con.logoutAsGuest();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, ontap) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: ontap,
    );
  }
}
