import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../sign_in.dart';
import 'l10n/sign_in_localizations.dart';
import 'sign_in_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen(
      {Key? key,
      this.onSignUpTap,
      this.onForgotMyPasswordTap,
      required this.onSignInSuccess,
      required this.userRepository})
      : super(key: key);

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(userRepository: userRepository),
      child: SignInView(
        onSignInSuccess: onSignInSuccess,
        onSignUpTap: onSignUpTap,
        onForgotMyPasswordTap: onForgotMyPasswordTap,
      ),
    );
  }
}

@visibleForTesting
class SignInView extends StatelessWidget {
  const SignInView(
      {Key? key,
      required this.onSignInSuccess,
      this.onSignUpTap,
      this.onForgotMyPasswordTap})
      : super(key: key);

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = SignInLocalizations.of(context);
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(l10n.appBarTitle),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: Spacing.mediumLarge),
            child: _SignInForm(
              onSignUpTap: onSignUpTap,
              onForgotMyPasswordTap: onForgotMyPasswordTap,
              onSignInSuccess: onSignInSuccess,
            ),
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({
    Key? key,
    required this.onSignInSuccess,
    this.onSignUpTap,
    this.onForgotMyPasswordTap,
  }) : super(key: key);

  final VoidCallback? onSignUpTap;
  final VoidCallback? onForgotMyPasswordTap;
  final VoidCallback onSignInSuccess;

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _userFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignInCubit>();
    _userFocusNode.addListener(() {
      if (!_userFocusNode.hasFocus) {
        cubit.onUsernameUnfocused();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.onUsernameUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = SignInLocalizations.of(context);
    return BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
      if (state.submissionStatus == SubmissionStatus.success) {
        widget.onSignInSuccess();
        return;
      }

      if (state.submissionStatus.hasSubmissionError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            state.submissionStatus == SubmissionStatus.invalidCredentialsError
                ? SnackBar(
                    content: Text(l10n.invalidCredentialsErrorMessage),
                  )
                : const GenericErrorSnackBar(),
          );
      }
    }, builder: (context, state) {
      return Column(
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            autofocus: false,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.person),
                labelText: l10n.usernameTextFieldLabel),
          ),
          const SizedBox(height: Spacing.large),
          TextField(
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.password),
                labelText: l10n.passwordTextFieldLabel),
          ),
          TextButton(
              onPressed: () {}, child: Text(l10n.forgotMyPasswordButtonLabel)),
          const SizedBox(height: Spacing.small),
          ExpandedElevatedButton(label: l10n.signInButtonLabel),
          const SizedBox(height: Spacing.xxxLarge),
          Text(l10n.signUpOpeningText),
          TextButton(onPressed: () {}, child: Text(l10n.signUpButtonLabel))
        ],
      );
    });
  }
}
