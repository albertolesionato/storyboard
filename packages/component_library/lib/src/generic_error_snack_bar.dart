import 'package:flutter/material.dart';

class GenericErrorSnackBar extends SnackBar {
  const GenericErrorSnackBar({Key? key})
      : super(
    key: key,
    content: const Text('General Error'),
  );
}