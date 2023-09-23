import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videocallingapp/home.dart';
import 'package:zego_zimkit/compnents/conversation_list.dart';
import 'package:zego_zimkit/pages/message_list_page.dart';

class ZIMKitDemoHomePage extends StatelessWidget {
  const ZIMKitDemoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          actions: const [HomePagePopup()],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ZIMKitMessageListPage(
                    conversationID: conversation.id,
                    conversationType: conversation.type,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
