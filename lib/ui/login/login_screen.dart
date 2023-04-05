import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/theme/app_theme.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_survey/gen/fonts.gen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late AnimationController _overlayOpacityAnimationController;
  late Animation<Offset> _positionAnimation;

  final _textTheme = AppTheme.light().textTheme;
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _nimbleLogo = Assets.images.splashLogoWhite.image();
  final _overlayImage = Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/login_overlay.png"),
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

    _overlayOpacityAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
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

    _logoPositionAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _overlayOpacityAnimationController.forward();
      }
    });

    _logoOpacityAnimationController.forward();
  }

  TextStyle _textFieldHintTextStyle() => TextStyle(
        color: Colors.white.withOpacity(0.3),
        fontFamily: FontFamily.neuzeit,
        fontSize: AppDimensions.textSize17,
        fontWeight: FontWeight.w400,
      );

  TextStyle? _textFieldTextStyle() => _textTheme.bodySmall;

  TextStyle _loginButtonTextStyle() => const TextStyle(
        color: AppColors.blackRussian,
        fontFamily: FontFamily.neuzeit,
        fontSize: AppDimensions.textSize17,
        fontWeight: FontWeight.w800,
      );

  InputDecoration _textFieldInputDecoration(String placeholderText) =>
      InputDecoration(
        fillColor: Colors.white24,
        filled: true,
        hintText: placeholderText,
        hintStyle: _textFieldHintTextStyle(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spacing18,
          horizontal: AppDimensions.spacing12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppDimensions.radius12),
        ),
      );

  EdgeInsets _textFieldEdgeInsets() => const EdgeInsets.fromLTRB(
        AppDimensions.spacing24,
        AppDimensions.spacing0,
        AppDimensions.spacing24,
        AppDimensions.spacing20,
      );

  EdgeInsets _buttonEdgeInsets() => const EdgeInsets.fromLTRB(
        AppDimensions.spacing24,
        AppDimensions.spacing0,
        AppDimensions.spacing24,
        AppDimensions.spacing0,
      );

  Padding _emailTextField(BuildContext context) => Padding(
        padding: _textFieldEdgeInsets(),
        child: TextField(
          style: _textFieldTextStyle(),
          keyboardType: TextInputType.emailAddress,
          decoration: _textFieldInputDecoration(
            AppLocalizations.of(context)?.email ?? 'Email',
          ),
          controller: _emailTextFieldController,
        ),
      );

  Padding _passwordTextField(BuildContext context) => Padding(
        padding: _textFieldEdgeInsets(),
        child: TextField(
          style: _textFieldTextStyle(),
          keyboardType: TextInputType.text,
          decoration: _textFieldInputDecoration(
            AppLocalizations.of(context)?.password ?? 'Password',
          ),
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          controller: _passwordTextFieldController,
        ),
      );

  Padding _loginButton(BuildContext context) => Padding(
        padding: _buttonEdgeInsets(),
        child: SizedBox(
          height: 56.0,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              // TODO: Integration task #10
            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radius10),
                ),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)?.login ?? 'Login',
              style: _loginButtonTextStyle(),
            ),
          ),
        ),
      );

  Stack _buildLoginScreen(BuildContext context) => Stack(
        children: [
          DimmedBackground(
            background: Assets.images.splashBackground.path,
            startOpacity: 0.01,
            endOpacity: 1.0,
            isAsset: true,
          ),
          FadeTransition(
            opacity: _overlayOpacityAnimationController,
            child: _overlayImage,
          ),
          FadeTransition(
            opacity: _logoOpacityAnimationController,
            child: SlideTransition(
              position: _positionAnimation,
              child: Center(child: _nimbleLogo),
            ),
          ),
          FadeTransition(
            opacity: _overlayOpacityAnimationController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailTextField(context),
                _passwordTextField(context),
                _loginButton(context),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildLoginScreen(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _logoOpacityAnimationController.dispose();
    _logoPositionAnimationController.dispose();
    _overlayOpacityAnimationController.dispose();
    _emailTextFieldController.dispose();
    _passwordTextFieldController.dispose();
  }
}
