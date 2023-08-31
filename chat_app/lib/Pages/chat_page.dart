import 'package:chat_app/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chat_app/Cubits/ChatCubit/chat_stat.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Widgets/chat_buble.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';

  TextEditingController controller = TextEditingController();
  final _Controller = ScrollController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              kLogo,
              height: 60,
            ),
            const Text(
              ' Chat',
              style: TextStyle(
                fontSize: 26,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                

                return ListView.builder(
                  reverse: true,
                  controller: _Controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id ==
                            BlocProvider.of<ChatCubit>(context).email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFrind(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please type a message';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Send Message ...',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<ChatCubit>(context).sendMessage(
                            message: controller.text,
                            email: BlocProvider.of<ChatCubit>(context).email);
                        _Controller.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                      controller.clear();
                    },
                    child: const Icon(
                      Icons.send,
                      color: kPrimaryColor,
                      size: 28,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
