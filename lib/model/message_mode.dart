import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  // 'message': message,
  // 'timeStamp': DateTime.now(),
  // 'senderEmail': dataBox.get('email'),
  // 'name': dataBox.get('name'),
  // 'isUrl': isUrl ?? false,
  // 'teamCode': myController.teamData.value.teamCode,

  final String message;
  final Timestamp timestamp;
  final String senderEmail;
  final String name;
  final bool isUrl;
  final String teamCode;

  const MessageModel({
    required this.message,
    required this.timestamp,
    required this.senderEmail,
    required this.name,
    required this.isUrl,
    required this.teamCode,
  });
}
