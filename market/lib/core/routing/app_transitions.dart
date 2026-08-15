import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTransitions {
  static CustomTransitionPage fade({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder:
          (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
    );
  }

  static CustomTransitionPage slideFromRight({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder:
          (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            final animationOffset =
                Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                );

            return SlideTransition(
              position: animationOffset,
              child: child,
            );
          },
    );
  }

  static CustomTransitionPage slideFromLeft({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder:
          (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            final animationOffset =
                Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut,
                  ),
                );

            return SlideTransition(
              position: animationOffset,
              child: child,
            );
          },
    );
  }

  static CustomTransitionPage slideFromBottom({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder:
          (
            context,
            animation,
            secondaryAnimation,
            child,
          ) {
            final animationOffset =
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

            return SlideTransition(
              position: animationOffset,
              child: child,
            );
          },
    );
  }
}
