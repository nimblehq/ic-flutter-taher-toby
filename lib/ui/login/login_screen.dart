import 'dart:ui';
import 'package:flutter_survey/app_navigator.dart';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/ui/login/login_view_model.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/usecases/store_auth_token_use_case.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/widget/snack_bar.dart';
import 'package:email_validator/email_validator.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(
    getIt.get<LogInUseCase>(),
    getIt.get<StoreAuthTokenUseCase>(),
  );
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoOpacityAnimationController;
  late AnimationController _logoPositionAnimationController;
  late AnimationController _overlayOpacityAnimationController;
  late Animation<Offset> _positionAnimation;

  final _appNavigator = getIt.get<AppNavigator>();
  final _emailTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();
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
          logIn();
        },
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radius10),
            ),
          ),
        ),
        child: ref.watch(loginViewModelProvider).maybeWhen(
              loading: () => const CircularProgressIndicator(
                color: AppColors.blackRussian,
              ),
              orElse: () => Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.blackRussian,
                    ),
              ),
            ),
      );

  Stack _buildLoginScreen(BuildContext context) {
    return Stack(
      children: [
        DimmedBackground(
          background: Assets.images.splashBackground.path,
          startOpacity: 0.01,
          endOpacity: 1.0,
          isAsset: true,
        ),
        FadeTransition(
          opacity: _overlayOpacityAnimationController,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 25.0,
              sigmaY: 25.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
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
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginViewModelProvider, (_, loginState) {
      loginState.maybeWhen(
        loginSuccess: () => _navigateToHomeScreen(),
        loginError: (errorMessage) => _showError(errorMessage),
        orElse: () {},
      );
    });
    return Scaffold(
      body: _buildLoginScreen(context),
      resizeToAvoidBottomInset: false,
    );
  }

  void _showError(String errorMessage) {
    showSnackBar(context, errorMessage);
  }

  bool _isCredentialsValid(String email, String password) {
    return EmailValidator.validate(email) &&
        password.isNotEmpty &&
        password.length >= 8;
  }

  void _navigateToHomeScreen() {
    _appNavigator.navigateToHomeScreen(context: context);
  }

  void logIn() async {
    final String email = _emailTextFieldController.text;
    final String password = _passwordTextFieldController.text;
    if (_isCredentialsValid(email, password)) {
      ref.read(loginViewModelProvider.notifier).logIn(
            email,
            password,
          );
    } else {
      _showError(AppLocalizations.of(context)!.login_validation_error);
    }
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
