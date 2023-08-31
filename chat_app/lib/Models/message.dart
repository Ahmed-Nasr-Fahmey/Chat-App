import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class Message {
  final String message;
  final String id;
  final Timestamp messageTime;
  Message(this.message, this.id, this.messageTime);
  factory Message.fromjson(jsonDate) {
    return Message(jsonDate[kMessage], jsonDate['id'], jsonDate[kCreatedAt]);
  }
}
