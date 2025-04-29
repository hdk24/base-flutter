import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({required this.counterResult});

  final Result<int> counterResult;

  factory HomeState.initial() {
    return HomeState(counterResult: InitialState());
  }

  HomeState copyWith({
    Result<int>? counterResult,
  }) {
    return HomeState(
      counterResult: counterResult ?? this.counterResult,
    );
  }

  @override
  List<Object?> get props => [counterResult];
}
