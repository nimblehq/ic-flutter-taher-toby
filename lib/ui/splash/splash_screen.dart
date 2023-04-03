import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SpalshScreenState();
  }
}

class _SpalshScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoOpacityAnimationController;
  late AnimationController _logoPositionAnimationController;
  late Animation<Offset> _positionAnimation;

  final _nimbleLogo = Image.asset("assets/images/splash_logo_white.png");
  final _backgroundImage = Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/splash_background.png"),
          fit: BoxFit.cover),
    ),
  );

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
      begin: const Offset(0, 0),
      end: const Offset(0, -0.3),
    ).animate(_logoPositionAnimationController);

    _logoOpacityAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoPositionAnimationController.forward();
      }
    });

    _logoOpacityAnimationController.forward();
  }

  Stack _uiStack() => Stack(
        children: [
          _backgroundImage,
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(1.0)
                ],
              ),
            ),
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
  void dispose() {
    super.dispose();
    _logoOpacityAnimationController.dispose();
    _logoPositionAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return _uiStack();
  }
}
