import 'package:equatable/equatable.dart';
import 'package:form_fields/form_fields.dart';

class LoginState extends Equatable {
  const LoginState({
  this.username = const Username.unvalidated()
});

  final Username username;

  @override
  List<Object?> get props => [
    username
  ];
}