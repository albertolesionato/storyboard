import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';

class Username extends FormzInput<String, UsernameValidationError>
    with EquatableMixin {
  const Username.unvalidated([String value = ''])
      : isAlreadyTaken = false,
        super.pure(value);

  const Username.validated(String value, {this.isAlreadyTaken = false})
      : super.dirty(value);

  final bool isAlreadyTaken;

  @override
  List<Object?> get props => [value, pure];

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    }
    if (isAlreadyTaken) {
      return UsernameValidationError.alreadyTaken;
    }
    if (value.length < 8 || value.length > 120) {
      return UsernameValidationError.invalid;
    }
    return null;
  }
}

enum UsernameValidationError { empty, invalid, alreadyTaken }
