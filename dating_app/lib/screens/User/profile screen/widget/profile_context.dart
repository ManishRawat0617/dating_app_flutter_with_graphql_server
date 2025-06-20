import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/text_constants.dart';
import 'package:dating_app/core/service/shared_perference_service.dart';
import 'package:dating_app/data/models/userModel.dart';
import 'package:dating_app/screens/User/profile%20screen/bloc/profile_page_bloc.dart';
import 'package:dating_app/screens/User/profile%20screen/graphql/profile_page_graphql.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileContext extends StatefulWidget {
  const ProfileContext({super.key});

  @override
  State<ProfileContext> createState() => _ProfileContextState();
}

class _ProfileContextState extends State<ProfileContext> {
  late dynamic loggedUser;
  UserModel? savedUser = SharedPrefsService.getUser();
  @override
  void initState() {
    getUserProfile(user_id: SharedPrefsService.getUserID().toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createMainBody(context, size),
          BlocBuilder<ProfilePageBloc, ProfilePageState>(
            buildWhen: (_, currState) =>
                currState is LoadingState ||
                currState is ErrorState ||
                currState is EditDetailsState,
            builder: (context, state) {
              if (state is LoadingState) {
                return LoadingWidget();
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _createMainBody(BuildContext content, Size size) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.05,
        top: size.height * 0.02,
        bottom: size.height * 0.12, // <-- ADD EXTRA BOTTOM PADDING
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _createAvatar(context, savedUser!.name.toUpperCase()),
          SizedBox(height: size.height * 0.03),
          _createPersonalDetailsSection(size),
          SizedBox(height: size.height * 0.04),
          utilitiesSection(size),
        ],
      ),
    );
  }

  Widget _createAvatar(BuildContext context, String username) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * 0.3,
          height: size.width * 0.3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.pinkAccent, width: 3),
          ),
          child: const Icon(Icons.person, size: 50, color: Colors.pinkAccent),
        ),
        SizedBox(height: size.height * 0.02),
        TextWidget(
          title: username,
          textSize: size.width * 0.05,
          boldness: FontWeight.bold,
        ),
        SizedBox(height: size.height * 0.01),
        TextWidget(
          title: ProfilePageText.activeSince + "jfdkjd",
          textSize: size.width * 0.035,
          boldness: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _createPersonalDetailsSection(Size size) {
    final bloc = BlocProvider.of<ProfilePageBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const TextWidget(
              title: ProfilePageText.personalDetails,
              textSize: 18,
              boldness: FontWeight.bold,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                bloc.add(const EditProfileTappedEvent());
              },
              icon: const Icon(Icons.edit, size: 18),
              label: Text(ProfilePageText.edit, style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: ColorConstants.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ColorConstants.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: Column(
              children: [
                _createTile(
                    icon: Icons.phone,
                    label: ProfilePageText.phone,
                    value: savedUser!.phone_number),
                const Divider(color: ColorConstants.primary),
                _createTile(
                    icon: Icons.email,
                    label: ProfilePageText.email,
                    value: savedUser!.email),
                const Divider(color: ColorConstants.primary),
                _createTile(
                    icon: Icons.location_on,
                    label: ProfilePageText.address,
                    value: savedUser!.location),
                const Divider(color: ColorConstants.primary),
                _createTile(
                    icon: Icons.work,
                    label: ProfilePageText.occupation,
                    value: savedUser!.occupation),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: ColorConstants.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(fontSize: 14, color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }

  Widget utilitiesSection(Size size) {
    final bloc = BlocProvider.of<ProfilePageBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          title: ProfilePageText.utilities,
          textSize: 18,
          boldness: FontWeight.bold,
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstants.primary,
            border: Border.all(color: ColorConstants.primary, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Column(
              children: [
                _createUtilityTile(
                    icon: Icons.image_rounded,
                    label: ProfilePageText.photoUploaded),
                const Divider(color: ColorConstants.primary),
                _createUtilityTile(
                    icon: Icons.analytics_outlined,
                    label: ProfilePageText.usageAnalytics),
                const Divider(color: ColorConstants.primary),
                _createUtilityTile(
                    icon: Icons.help_outline_rounded,
                    label: ProfilePageText.askHelpDesk),
                const Divider(color: ColorConstants.primary),
                _createUtilityTile(
                    icon: Icons.settings_rounded,
                    label: ProfilePageText.appSettings),
                const Divider(color: ColorConstants.primary),
                _createUtilityTile(
                    onTap: () {
                      bloc.add(LogOutTappedEvent());
                    },
                    icon: Icons.logout_rounded,
                    label: ProfilePageText.logOut),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _createUtilityTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.pinkAccent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: ColorConstants.textBlack,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
