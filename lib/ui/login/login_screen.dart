import 'dart:ui';
import 'package:flutter_survey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/theme/app_colors.dart';
import 'package:flutter_survey/theme/app_dimensions.dart';
import 'package:flutter_survey/ui/login/login_state.dart';
import 'package:flutter_survey/ui/login/login_view_model.dart';
import 'package:flutter_survey/ui/widget/dimmed_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_survey/usecases/log_in_use_case.dart';
import 'package:flutter_survey/di/di.dart';
import 'package:flutter_survey/utils/storage/secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_survey/ui/widget/snack_bar.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(getIt.get<LogInUseCase>(), getIt.get<SecureStorage>());
});

final _loginStatusProvider = StreamProvider.autoDispose<bool?>(
    (ref) => ref.watch(loginViewModelProvider.notifier).isLoginSucceed);

final _loginErrorStatusProvider = StreamProvider.autoDispose<String?>(
    (ref) => ref.watch(loginViewModelProvider.notifier).loginError);

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

  bool _isLoading = false;
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
          // TODO: Integration task #10
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
        child: _isLoading
            ? const CircularProgressIndicator(
                color: AppColors.blackRussian,
              )
            : Text(
                AppLocalizations.of(context)!.login,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.blackRussian,
                    ),
              ),
      );

  Stack _buildLoginScreen(
      BuildContext context, bool isLoginSucceed, String errorMessage) {
    if (isLoginSucceed) {
      Future.delayed(Duration.zero, () async {
        context.go("/home");
      });
    }
    if (errorMessage.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, errorMessage);
    }
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
    final isLoginSucceed = ref.watch(_loginStatusProvider).value ?? false;
    final errorMessage = ref.watch(_loginErrorStatusProvider).value ?? "";
    return Material(
      child: Scaffold(
        body: ref.watch(loginViewModelProvider).when(
              init: () =>
                  _buildLoginScreen(context, isLoginSucceed, errorMessage),
              loading: () =>
                  _buildLoginScreen(context, isLoginSucceed, errorMessage),
              loginSuccess: () =>
                  _buildLoginScreen(context, isLoginSucceed, errorMessage),
              loginError: () =>
                  _buildLoginScreen(context, isLoginSucceed, errorMessage),
            ),
      ),
    );
  }

  void logIn() async {
    if (_isLoading) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    ref.read(loginViewModelProvider.notifier).logIn(
          _emailTextFieldController.text,
          _passwordTextFieldController.text,
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
