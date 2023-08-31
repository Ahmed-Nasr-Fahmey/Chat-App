import 'package:chat_app/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chat_app/Cubits/LoginCubit/login_cubit.dart';
import 'package:chat_app/Cubits/LoginCubit/login_stat.dart';
import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/register_page.dart';
import 'package:chat_app/Widgets/custom_button.dart';
import 'package:chat_app/Widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Helper/show_snack_bar.dart';
import '../constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStat>(
      listener: (context, state) {
        if (state is LoginLoadingStat) {
          BlocProvider.of<LoginCubit>(context).isLoading = true;
        } else if (state is LoginSuccessStat) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          BlocProvider.of<ChatCubit>(context).email =
              BlocProvider.of<LoginCubit>(context).email;
          Navigator.pushNamed(context, ChatPage.id,
              arguments: BlocProvider.of<LoginCubit>(context).email);
          BlocProvider.of<LoginCubit>(context).isLoading = false;
        } else if (state is LoginFaliureStat) {
          showSnackBar(context, state.erorrMessage);
          BlocProvider.of<LoginCubit>(context).isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: BlocProvider.of<LoginCubit>(context).isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: BlocProvider.of<LoginCubit>(context).formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      BlocProvider.of<LoginCubit>(context).email = data;
                    },
                    lableText: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    onChanged: (data) {
                      BlocProvider.of<LoginCubit>(context).password = data;
                    },
                    lableText: 'Password',
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (BlocProvider.of<LoginCubit>(context)
                          .formKey
                          .currentState!
                          .validate()) {
                        await BlocProvider.of<LoginCubit>(context).loginUser(
                            email: BlocProvider.of<LoginCubit>(context).email!,
                            password:
                                BlocProvider.of<LoginCubit>(context).password!);
                      }
                    },
                    text: 'Login',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white60,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          '     Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffc7ede6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
