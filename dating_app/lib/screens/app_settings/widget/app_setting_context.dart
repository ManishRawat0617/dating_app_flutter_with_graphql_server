import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class AppSettingsContext extends StatelessWidget {
  const AppSettingsContext({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return _createMainBody(context, size);
  }

  Widget _createMainBody(BuildContext context, Size size) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(TextConstants.account),
          settingTile(
            icon: Mdi.account_outline,
            title: TextConstants.editProfile,
            onTap: () {},
          ),
          settingTile(
            icon: Mdi.lock_outline,
            title: TextConstants.changePassword,
            onTap: () {},
          ),
          settingTile(
            icon: Mdi.shield_check_outline,
            title: TextConstants.verifyIdentity,
            onTap: () {},
          ),
          sectionTitle(TextConstants.preferences),
          settingTile(
            icon: Mdi.bell_outline,
            title: TextConstants.notifications,
            onTap: () {},
          ),
          settingTile(
            icon: Mdi.palette_outline,
            title: TextConstants.theme,
            onTap: () {},
          ),
          settingTile(
            icon: Mdi.translate,
            title: TextConstants.language,
            onTap: () {},
          ),
          sectionTitle(TextConstants.support),
          settingTile(
            icon: Mdi.help_circle_outline,
            title: TextConstants.helpCenter,
            onTap: () {},
          ),
          settingTile(
            icon: Mdi.information_outline,
            title: TextConstants.aboutUs,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          settingTile(
            icon: Mdi.logout_variant,
            title: TextConstants.logOut,
            onTap: () {
              // TODO: Add logout logic
            },
            color: Colors.redAccent,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextWidget(
        title: title,
        textSize: 16,
        boldness: FontWeight.bold,
        textColor: Colors.grey.shade700,
      ),
    );
  }

  Widget settingTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
    Color? textColor,
  }) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color ?? Colors.white,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: Iconify(icon,
            size: 26,
            color: color != null ? Colors.white : ColorConstants.primary),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: textColor ?? ColorConstants.primary,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: color != null ? Colors.white70 : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
