import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/componets/text_filed.dart';
import 'package:mini_chat_app/componets/visibleFAB.dart';
import 'package:mini_chat_app/services/auth/auth_login_services.dart';
import 'package:mini_chat_app/services/chat_services/chat_services.dart';
import 'package:mini_chat_app/services/chat_services/recievemessage_chat_service.dart';
import 'package:mini_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String title;
  const ChatPage({super.key, required this.title, required this.recieverID});
  final String recieverID;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController messagecontroller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final _authservice = AuthLoginServices();

  final _resievemessageservice = ResieveMessageService();
  final _sendmessageservice=SendMessageService();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrolldown());
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () => scrolldown());
  }

  void scrolldown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn);
  }

  bool isdown() {
    scrolldown();
    return false;
  }

  @override
  void dispose() {
    super.dispose();
    messagecontroller.dispose();
  }

  //send message
  void sendmessage() {
    if (messagecontroller.text.isNotEmpty) {
      _sendmessageservice.sendmessage(widget.recieverID, messagecontroller.text);
      // clear text controller
      messagecontroller.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton:   VisableFabState(
        scrollController: scrollController,
        scrooldown: isdown,
      ) ,
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
        
          _builduserinput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String userID = _authservice.getcurrentuser()!.uid;
    return StreamBuilder(
        stream: _resievemessageservice.getmessages(userID, widget.recieverID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          }
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageitem(doc, context))
                .toList(),
          );
        });
  }

  Widget _buildMessageitem(QueryDocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser = data["senderid"] == _authservice.getcurrentuser()!.uid;
    bool isdarkmode =
        Provider.of<ThemeProvider>(context, listen: false).isdarkmode;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: iscurrentuser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color: iscurrentuser
                        ? (isdarkmode
                            ? Colors.green.shade600
                            : Colors.grey.shade500)
                        : (isdarkmode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                child: Text(
                  data['message'],
                  style: TextStyle(
                      color: iscurrentuser
                          ? (isdarkmode ? Colors.black : Colors.white)
                          : (isdarkmode ? Colors.white : Colors.black)),
                )),
          ],
        ),
      ),
    );
  }

  Widget _builduserinput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
                focusNode: _focusNode,
                hinttext: "New Message",
                obsecure: false,
                textEditingController: messagecontroller),
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: sendmessage,
                icon: const Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
