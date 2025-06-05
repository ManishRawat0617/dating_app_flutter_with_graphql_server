import 'package:dating_app/core/constants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';

class AppSettingsContext extends StatelessWidget {
  const AppSettingsContext({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _createMainBody(context, size);
  }

  Widget _createMainBody(BuildContext context, Size size) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(TextConstants.account),
          settingTile(
            icon: Icons.person_outline,
            title: TextConstants.editProfile,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.lock_outline,
            title: TextConstants.changePassword,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.verified_user_outlined,
            title: TextConstants.verifyIdentity,
            onTap: () {},
          ),
          sectionTitle(TextConstants.preferences),
          settingTile(
            icon: Icons.notifications_none,
            title: TextConstants.notifications,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.palette_outlined,
            title: TextConstants.theme,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.language_outlined,
            title: TextConstants.language,
            onTap: () {},
          ),
          sectionTitle(TextConstants.support),
          settingTile(
            icon: Icons.help_outline,
            title: TextConstants.helpCenter,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.info_outline,
            title: TextConstants.aboutUs,
            onTap: () {},
          ),
          settingTile(
            icon: Icons.logout,
            title: TextConstants.logOut,
            onTap: () {
              // Add logout logic
            },
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: TextWidget(
        title: title,
        textSize: 18,
        boldness: FontWeight.bold,
      ),
    );
  }

  Widget settingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: color ?? ColorConstants.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pinkAccent, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.8)),
          ],
        ),
      ),
    );
  }
}
