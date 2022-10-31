import 'package:flutter/material.dart';

class EmptyError implements Exception {
  final message;
  EmptyError({@required this.message});
}
