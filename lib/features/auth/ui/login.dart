import 'package:all_event/constant/global.dart';
import 'package:all_event/core/theme/app_textstyle.dart';
import 'package:all_event/features/auth/cubit/auth_cubit.dart';
import 'package:all_event/features/events/ui/event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Text(
          "Please Note that I have not focus much on the UI designing part, I only tried to achieve all the functionality\n\nPlease Login with google to go to Event Listing screen and there will have all the API call and business Logic",
          style: AppTextStyle.body.small.semiBold.italic,
        )
      ],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Login Screen", style: AppTextStyle.display.medium.white),
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state.apiState == ApiState.loading) {
              showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
            }
            if (state.apiState == ApiState.error) {
              Navigator.maybePop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error ?? "")));
            }
            if (state.apiState == ApiState.loaded) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: Text("Login With Google", style: AppTextStyle.display.small.white),
              onPressed: () {
                context.read<AuthCubit>().signIn();
              },
            );
          },
        ),
      ),
    );
  }
}
