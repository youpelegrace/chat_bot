import 'package:chst_bot/chat_widget.dart';
import 'package:chst_bot/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController chatController = TextEditingController();
  late final GenerativeModel _generativeModel;
  late final ChatSession _chatSession;
  final List<Map<String, dynamic>> _chatList = [];
  bool isLoading = false;

  @override
  void initState() {
    _generativeModel = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    _chatSession = _generativeModel.startChat();
    super.initState();
  }

  void sendResponse(text) async {
    setState(() {
      isLoading = true;
    });
    late final GenerateContentResponse response;

    final content = Content.text(text);
    response = await _chatSession.sendMessage(content);

    setState(() {
      _chatList.add({
        'message': response.text,
        "isSender": false,
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Chat Bot"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: _chatList.length,
                  itemBuilder: (__, index) {
                    return ChatWidget(
                      chat: _chatList[index],
                      shouldAnimate: true,
                    );
                  })),
          if (isLoading) ...[
            const SpinKitThreeBounce(color: Colors.black, size: 18)
          ],
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.purple.withOpacity(0.10),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 5, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      decoration: const InputDecoration.collapsed(
                          hintText: 'how can i help you today?',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (chatController.text.isNotEmpty) {
                          setState(() {
                            _chatList.add({
                              'message': chatController.text,
                              "isSender": true,
                            });
                          });
                        }

                        sendResponse(chatController.text);
                        chatController.clear();
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
