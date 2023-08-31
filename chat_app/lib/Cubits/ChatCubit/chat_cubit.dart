import 'package:chat_app/Cubits/ChatCubit/chat_stat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/message.dart';
import '../../constants.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messagesList = [];
  String? email;
  void sendMessage({required String message, required String? email}) {
    messages.add({
      kMessage: message,
      kCreatedAt: Timestamp.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages.snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromjson(doc));
      }
      messagesList.sort((a, b) => a.messageTime.compareTo(b.messageTime));
      messagesList = messagesList.reversed.toList();
      emit(ChatSuccessState(messagesList: messagesList));
    });
  }
}
