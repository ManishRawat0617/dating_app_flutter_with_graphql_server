import 'package:dating_app/core/constants/path_constants.dart';
import 'package:dating_app/screens/subscription/bloc/subscription_page_bloc.dart';
import 'package:dating_app/screens/subscription/page/continu3.dart';
import 'package:dating_app/screens/subscription/widget/subscription_page_content.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/core/constants/color_constants.dart'; // your color constants file
import 'package:dating_app/screens/common_widget/text_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // your custom TextWidget

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SubscriptionPageBloc(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SubscriptionPageBloc, SubscriptionPageState>(
        listener: (context, state) {
      if (state is PaymentSuccessful) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubscriptionSuccessPage()));
      }
    }, builder: (context, state) {
      return SubscriptionPageContent();
    });
  }
}
