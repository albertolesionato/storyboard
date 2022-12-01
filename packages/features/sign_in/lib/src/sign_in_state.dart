import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';

class SignInState extends Equatable {
  const SignInState(
      {this.username = const Username.unvalidated(),
      this.password = const Password.unvalidated(),
      this.submissionStatus = SubmissionStatus.idle});

  final Username username;
  final Password password;
  final SubmissionStatus submissionStatus;

  SignInState copyWith(
      {Username? username,
      Password? password,
      SubmissionStatus? submissionStatus}) {
    return SignInState(
        username: username ?? this.username,
        password: password ?? this.password,
        submissionStatus: submissionStatus ?? this.submissionStatus);
  }

  @override
  List<Object?> get props => [username, password];
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  invalidCredentialsError,
}
