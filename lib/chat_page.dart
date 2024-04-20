import 'package:chst_bot/constants.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
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
          const Expanded(
            child: Column(),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: primartColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 5, bottom: 20),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'how can i help you today?',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
