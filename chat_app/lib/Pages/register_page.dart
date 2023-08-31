import 'package:chat_app/Cubits/RegisterCubit/register_cubit.dart';
import 'package:chat_app/Cubits/RegisterCubit/register_stat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Cubits/ChatCubit/chat_cubit.dart';
import '../Helper/show_snack_bar.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_text_form_field.dart';
import '../constants.dart';
import 'chat_page.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';

  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStat>(
      listener: (context, state) {
        if (state is RegisterLoadingStat) {
          BlocProvider.of<RegisterCubit>(context).isLoading = true;
        } else if (state is RegisterSuccessStat) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          BlocProvider.of<ChatCubit>(context).email =
              BlocProvider.of<RegisterCubit>(context).email;
          Navigator.pushNamed(context, ChatPage.id,
              arguments: BlocProvider.of<RegisterCubit>(context).email);
          BlocProvider.of<RegisterCubit>(context).isLoading = false;
        } else if (state is RegisterFaliureStat) {
          showSnackBar(context, state.erorrMessage);
          BlocProvider.of<RegisterCubit>(context).isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: BlocProvider.of<RegisterCubit>(context).isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: BlocProvider.of<RegisterCubit>(context).formKey,
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
                          'Sign Up',
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
                        BlocProvider.of<RegisterCubit>(context).email = data;
                      },
                      lableText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      onChanged: (data) {
                        BlocProvider.of<RegisterCubit>(context).password = data;
                      },
                      lableText: 'Password',
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (BlocProvider.of<RegisterCubit>(context)
                            .formKey
                            .currentState!
                            .validate()) {
                          await BlocProvider.of<RegisterCubit>(context)
                              .registerUser(
                                  email: BlocProvider.of<RegisterCubit>(context)
                                      .email!,
                                  password:
                                      BlocProvider.of<RegisterCubit>(context)
                                          .password!);
                        }
                      },
                      text: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '     Login',
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
        );
      },
    );
  }
}
