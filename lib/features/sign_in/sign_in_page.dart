import 'dart:developer';

import 'package:flutter/material.dart';

import '../../common/constants/constants.dart';
import '../../common/utils/utils.dart';
import '../../common/widgets/widgets.dart';
import '../../locator.dart';
import '../../services/sync_service/sync_service.dart';
import 'sign_in_controller.dart';
import 'sign_in_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with CustomModalSheetMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signInController = locator.get<SignInController>();
  final _syncController = locator.get<SyncController>();

  @override
  void initState() {
    super.initState();
    _signInController.addListener(_handleSignInStateChange);
    _syncController.addListener(_handleSyncStateChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signInController.dispose();
    _syncController.dispose();
    super.dispose();
  }

  void _handleSignInStateChange() {
    switch (_signInController.state.runtimeType) {
      case SignInStateLoading:
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
        break;
      case SignInStateSuccess:
        _syncController.syncFromServer();
        break;
      case SignInStateError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_signInController.state as SignInStateError).message,
          buttonText: "Try again",
        );
        break;
    }
  }

  void _handleSyncStateChange() {
    switch (_syncController.state.runtimeType) {
      case DownloadedDataFromServer:
        _syncController.syncToServer();
        break;
      case UploadedDataToServer:
        Navigator.pushNamedAndRemoveUntil(
          context,
          NamedRoute.home,
          (route) => false,
        );
        break;
      case SyncStateError:
      case UploadDataToServerError:
      case DownloadDataFromServerError:
        Navigator.pop(context);
        showCustomModalBottomSheet(
          context: context,
          content: (_syncController.state as SyncStateError).message,
          buttonText: "Tente novamente",
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoute.signIn,
            (route) => false,
          ),
        );
        break;
    }
  }

  void _onSignInButtonPressed() {
    final valid =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (valid) {
      _signInController.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } else {
      log("Erro ao logar");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bem vindo novamente!',
                textAlign: TextAlign.center,
                style: AppTextStyles.mediumText30.copyWith(
                  color: Colors.black,
                ),
              ),
              Image.asset(
                'assets/images/sign_in_image.png',
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      key: Keys.signInEmailField,
                      controller: _emailController,
                      labelText: "Email",
                      hintText: "john@email.com",
                      validator: Validator.validateEmail,
                    ),
                    PasswordFormField(
                      key: Keys.signInPasswordField,
                      controller: _passwordController,
                      labelText: "Senha",
                      hintText: "*********",
                      validator: Validator.validatePassword,
                      onEditingComplete: _onSignInButtonPressed,
                    ),
                  ],
                ),
              ),
              TextButton(
                key: Keys.forgotPasswordButton,
                onPressed: () => Navigator.popAndPushNamed(
                  context,
                  NamedRoute.forgotPassword,
                ),
                child: const Text('Esqueci a senha'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32.0,
                  right: 32.0,
                  top: 16.0,
                  bottom: 4.0,
                ),
                child: PrimaryButton(
                  key: Keys.signInButton,
                  text: 'Entrar',
                  onPressed: _onSignInButtonPressed,
                ),
              ),
              MultiTextButton(
                key: Keys.signInDontHaveAccountButton,
                onPressed: () => Navigator.popAndPushNamed(
                  context,
                  NamedRoute.signUp,
                ),
                children: [
                  Text(
                    'Não possui uma conta? ',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    'Crie uma aqui',
                    style: AppTextStyles.smallText.copyWith(
                      color: AppColors.greenOne,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
