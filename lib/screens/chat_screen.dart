import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_task_hub/constants/k_colors.dart';
import 'package:co_task_hub/constants/k_my_text.dart';
import 'package:co_task_hub/controller/get_controller.dart';
import 'package:co_task_hub/model/message_mode.dart';
import 'package:co_task_hub/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final WebViewController webViewController;
  @override
  void initState() {
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse('https://meet.google.com'),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where(Filter('teamCode',
                  isEqualTo: myController.teamData.value.teamCode))
              .orderBy('timeStamp')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<MessageModel> messageList = [];
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final List<DocumentSnapshot> documents =
                  snapshot.data?.docs.reversed.toList();
              for (DocumentSnapshot document in documents) {
                final Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                messageList.add(
                  MessageModel(
                    message: data['message'],
                    timestamp: data['timeStamp'],
                    senderEmail: data['senderEmail'],
                    name: data['name'],
                    isUrl: data['isUrl'],
                    teamCode: data['teamCode'],
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: ScrollController(),
                  addAutomaticKeepAlives: true,
                  itemCount: messageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isSender =
                        messageList[index].senderEmail == dataBox.get('email');

                    return Padding(
                      padding: EdgeInsets.only(bottom: index == 0 ? 5 : 0),
                      child: Visibility(
                        visible: messageList[index].isUrl == false,
                        replacement: Align(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: KMyText(
                                "${messageList[index].name}, added new file",
                                size: 14,
                              ),
                              trailing: InkWell(
                                onTap: () => launchUrl(
                                    Uri.parse(messageList[0].message)),
                                child: const Chip(
                                  label: Icon(
                                    Icons.file_download,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: BubbleNormal(
                          text: messageList[index].message,
                          color: isSender ? accentColor : cardColor,
                          textStyle: TextStyle(
                            color: isSender ? Colors.white : Colors.black,
                          ),
                          tail: true,
                          isSender: isSender,
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.only(top: 200),
                child: KMyText('No Message yet'),
              );
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MessageBar(
            onSend: (msg) => FirebaseServices().createMessage(message: msg),
          ),
        ),
      ],
    );
  }
}
