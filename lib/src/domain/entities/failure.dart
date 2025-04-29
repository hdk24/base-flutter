import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.code, required this.message});

  Failure copyWith({int? code, String? message}) {
    return Failure(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [code, message];
}
