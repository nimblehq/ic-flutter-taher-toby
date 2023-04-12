import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
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

  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
  final _nimbleLogo = Assets.images.splashLogoWhite.image();
  final _overlayImage = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Assets.images.loginOverlay.path),
        fit: BoxFit.cover,
      ),
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

  TextField _configuredTextField(BuildContext context, bool isEmail) =>
      TextField(
        style: Theme.of(context).textTheme.bodySmall,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: const InputDecoration()
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(
              hintText: isEmail
                  ? AppLocalizations.of(context)!.email
                  : AppLocalizations.of(context)!.password,
            ),
        obscureText: !isEmail,
        autocorrect: false,
        enableSuggestions: false,
        controller:
            isEmail ? _emailTextFieldController : _passwordTextFieldController,
      );

  TextButton _loginButton(BuildContext context) => TextButton(
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
          AppLocalizations.of(context)!.login,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.blackRussian,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.spacing24,
                    right: AppDimensions.spacing24,
                    bottom: AppDimensions.spacing20,
                  ),
                  child: _configuredTextField(context, true),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.spacing24,
                    right: AppDimensions.spacing24,
                    bottom: AppDimensions.spacing20,
                  ),
                  child: _configuredTextField(context, false),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacing24,
                  ),
                  child: SizedBox(
                    height: 56.0,
                    width: double.infinity,
                    child: _loginButton(context),
                  ),
                ),
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
