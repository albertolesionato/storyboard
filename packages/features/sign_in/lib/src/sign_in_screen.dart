import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
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
        cubit.onPasswordUnfocused();
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

      final hasSubmissionError = state.submissionStatus ==
              SubmissionStatus.genericError ||
          state.submissionStatus == SubmissionStatus.invalidCredentialsError;

      if (hasSubmissionError) {
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
      final usernameError =
          state.username.invalid ? state.username.error : null;
      final passwordError =
          state.password.invalid ? state.password.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == SubmissionStatus.inProgress;

      final cubit = context.read<SignInCubit>();
      return Column(
        children: [
          TextField(
            focusNode: _userFocusNode,
            onChanged: cubit.onUsernameChanged,
            textInputAction: TextInputAction.next,
            autofocus: false,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.person),
                labelText: l10n.usernameTextFieldLabel,
                enabled: !isSubmissionInProgress,
                errorText: usernameError == null
                    ? null
                    : (usernameError == UsernameValidationError.empty
                        ? l10n.usernameTextFieldEmptyErrorMessage
                        : l10n.usernameTextFieldInvalidErrorMessage)),
          ),
          const SizedBox(height: Spacing.large),
          TextField(
            focusNode: _passwordFocusNode,
            onChanged: cubit.onPasswordChanged,
            obscureText: true,
            onEditingComplete: cubit.onSubmit,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.password),
                enabled: !isSubmissionInProgress,
                labelText: l10n.passwordTextFieldLabel,
                errorText: passwordError == null
                    ? null
                    : (passwordError == PasswordValidationError.empty
                        ? l10n.passwordTextFieldEmptyErrorMessage
                        : l10n.passwordTextFieldInvalidErrorMessage)),
          ),
          TextButton(
              onPressed:
                  isSubmissionInProgress ? null : widget.onForgotMyPasswordTap,
              child: Text(l10n.forgotMyPasswordButtonLabel)),
          const SizedBox(height: Spacing.small),
          isSubmissionInProgress
              ? ExpandedElevatedButton.inProgress(label: l10n.signInButtonLabel)
              : ExpandedElevatedButton(
                  label: l10n.signInButtonLabel,
                  onTap: cubit.onSubmit,
                  icon: const Icon(
                    Icons.login,
                  ),
                ),
          const SizedBox(
            height: Spacing.xxxLarge,
          ),
          Text(
            l10n.signUpOpeningText,
          ),
          TextButton(
              onPressed: isSubmissionInProgress ? null : widget.onSignUpTap,
              child: Text(l10n.signUpButtonLabel))
        ],
      );
    });
  }
}
