import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/screens/common_widget/loading_widget.dart';
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:dating_app/screens/create_profile/bloc/personal_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuickIntroductionContent extends StatelessWidget {
  QuickIntroductionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          _createMainBody(context),
          BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
            buildWhen: (prev, curr) =>
                curr is LoadingState || curr is ErrorState,
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

  Widget _createMainBody(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 30),
            const TextWidget(
              title: "Quick introduction",
              textSize: 24,
              textColor: ColorConstants.primary,
              boldness: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            const TextWidget(
              title: "Add a bio, it brings flavor to your profile.",
              textSize: 16,
              textColor: Color.fromARGB(255, 5, 26, 54),
            ),
            const SizedBox(height: 20),
            const Text(
              "Bio",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            TextFormField(
              controller: bloc.bioController,
              onChanged: (value) {
                bloc.bioController.text = value;
                bloc.add(OnTextChangedQuickIntroduction(bio: value));
              },
              decoration: InputDecoration(
                hintText: "Type something about yourself...",
                filled: true,
                fillColor: ColorConstants.textFieldBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: ColorConstants.textFieldBorder.withOpacity(0.4),
                  ),
                ),
              ),
              maxLines: 4,
            ),
            const Spacer(),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == 3 ? ColorConstants.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final bloc = BlocProvider.of<PersonalDetailsBloc>(context);
    return BlocBuilder<PersonalDetailsBloc, PersonalDetailsState>(
      builder: (context, state) {
        final isEnabled =
            state is NextPageEnabledChangedState && state.isEnabled;

        return InkWell(
          onTap: isEnabled
              ? () {
                  bloc.add(NextPageUserPreferencesTapped());
                }
              : null,
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: isEnabled ? ColorConstants.primary : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: TextWidget(
                title: "Next",
                textColor: Colors.white,
                textSize: 18,
                boldness: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
