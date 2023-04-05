import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoOpacityAnimationController;
  late AnimationController _logoPositionAnimationController;
  late Animation<Offset> _positionAnimation;

  final _nimbleLogo = Assets.images.splashLogoWhite.image();

  @override
  void initState() {
    super.initState();

    _logoPositionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _logoOpacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _positionAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.3),
    ).animate(_logoPositionAnimationController);

    _logoOpacityAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoPositionAnimationController.forward();
      }
    });

    _logoOpacityAnimationController.forward();
  }

  Stack _buildLoginScreen() => Stack(
        children: [
          DimmedBackground(
            background: Assets.images.splashBackground.path,
            startOpacity: 0.01,
            endOpacity: 1.0,
            isAsset: true,
          ),
          FadeTransition(
            opacity: _logoOpacityAnimationController,
            child: SlideTransition(
              position: _positionAnimation,
              child: Center(child: _nimbleLogo),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _buildLoginScreen();
  }

  @override
  void dispose() {
    super.dispose();
    _logoOpacityAnimationController.dispose();
    _logoPositionAnimationController.dispose();
  }
}
