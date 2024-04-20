import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chst_bot/constants.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required Map<String, dynamic> chat,
    required bool shouldAnimate,
  })  : _chat = chat,
        _shouldAnimate = shouldAnimate;

  final Map<String, dynamic> _chat;
  final bool _shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _chat["isSender"] == true ? primaryColor : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              _chat["isSender"] == true
                  ? Icons.person
                  : Icons.chat_bubble_outline,
              size: 30,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: _chat["isSender"] == true
                  ? Text(
                      _chat["message"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : _shouldAnimate
                      ? DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  _chat["message"],
                                ),
                              ]),
                        )
                      : Text(
                          _chat["message"],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
