import 'package:flutter/material.dart';

// You can create a function for each type of transition,
// or a single function with a parameter for transition type.

// 1. Simple Slide Transition (from right to left)
Route createSlideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease; // Or Curves.easeOut, Curves.easeInOut

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

Route createSlideLeftToRightRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // The 'begin' offset determines where the page starts.
      // Offset(-1.0, 0.0) means it starts off-screen to the left.
      // Offset.zero (0.0, 0.0) means it ends at its normal position.
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease; // You can experiment with different curves like Curves.easeOut, Curves.easeInOut

      // Create a Tween that interpolates between the begin and end offsets.
      // Chain it with a CurveTween to apply the animation curve.
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      // Use a SlideTransition to apply the animation to the child widget (the new page).
      // The 'position' property is driven by the animation, which is transformed by the tween.
      return SlideTransition(
        position: animation.drive(tween),
        child: child, // The new page widget
      );
    },
    // Define the duration of the transition animation.
    transitionDuration: const Duration(milliseconds: 500),
    // You can also define reverseTransitionDuration if you want a different speed
    // when popping the route.
    // reverseTransitionDuration: const Duration(milliseconds: 300),
  );
}


// 2. Fade Transition
Route createFadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 700),
  );
}

// 3. Scale Transition
Route createScaleRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic, // A good curve for scaling
          ),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}

// Optional: A more generic function if you want to reuse common properties
// This is what packages like 'page_transition' do internally
// Route createCustomRoute(Widget page, {
//   required PageTransitionType transitionType, // You'd define this enum
//   Duration duration = const Duration(milliseconds: 400),
//   Curve curve = Curves.ease,
// }) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       // Implement a switch statement based on transitionType
//       switch (transitionType) {
//         case PageTransitionType.slideLeft:
//           // ... return SlideTransition
//         case PageTransitionType.fade:
//           // ... return FadeTransition
//         default:
//           return child;
//       }
//     },
//     transitionDuration: duration,
//   );
// }