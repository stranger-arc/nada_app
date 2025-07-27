import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AutoChangingTypingText extends StatelessWidget {
  // You can make these properties configurable if you want,
  // by passing them in the constructor.
  final List<String> texts;
  final TextStyle textStyle;
  final Duration typingSpeed;
  final Duration pauseDuration;

  const AutoChangingTypingText({
    Key? key,
    required this.texts,
    this.textStyle = const TextStyle(
      fontSize: 30.0,
      color: Colors.white, // Default color, can be overridden
      fontWeight: FontWeight.bold,
    ),
    this.typingSpeed = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle( // Use DefaultTextStyle to set a base style
        style: textStyle,
        child: AnimatedTextKit(
          animatedTexts: texts.map((text) => TypewriterAnimatedText(
            text,
            speed: typingSpeed,
            cursor: '|',
            // The textStyle here will merge with the DefaultTextStyle
            // You might want to remove it here if DefaultTextStyle is sufficient,
            // or keep it if you need specific styling for the typed text
            // that differs from the default.
          )).toList(),
          pause: pauseDuration,
          displayFullTextOnTap: false,
          stopPauseOnTap: false,
          isRepeatingAnimation: true,
          repeatForever: true,
          onTap: () {
            // Optional: Add some custom tap behavior if needed
            print("Tap Event on AutoChangingTypingText");
          },
        ),
      ),
    );
  }
}