import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

class Password extends FormzInput<String, PasswordValidationError>
    with EquatableMixin {
  const Password.unvalidated([String value = ''])
      :
        super.pure(value);

  const Password.validated(String value)
      :
        super.dirty(value);


  @override
  List<Object?> get props => [value, pure];

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }

    if (value.length < 8 || value.length > 120) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}

enum PasswordValidationError { empty, invalid }
