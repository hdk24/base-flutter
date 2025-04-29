import 'package:base_flutter/src/domain/entities/failure.dart';
import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
  const Result();
}

class InitialState<T> extends Result<T> {
  @override
  List<Object?> get props => [];
}

class LoadingState<T> extends Result<T> {
  @override
  List<Object?> get props => [];
}

class SuccessState<T> extends Result<T> {
  final T data;

  const SuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState<T> extends Result<T> {
  final Failure error;

  const ErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
