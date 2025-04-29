import 'package:equatable/equatable.dart';

class Pair<T, M> extends Equatable {
  final T first;
  final M second;

  const Pair({required this.first, required this.second});

  @override
  List<Object?> get props => [first, second];
}
