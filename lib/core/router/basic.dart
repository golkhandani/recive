import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static String name = 'OnboardingScreen';
  final int initialPage;
  const OnboardingScreen({super.key, this.initialPage = 0});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
