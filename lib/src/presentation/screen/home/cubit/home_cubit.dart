import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/domain/usecase/counter/decrement_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/get_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/increment_counter_value_use_case.dart';
import 'package:base_flutter/src/domain/usecase/counter/reset_counter_value_use_case.dart';
import 'package:base_flutter/src/presentation/screen/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCounterValueUseCase _getCounterValueUseCase;
  final IncrementCounterValueUseCase _incrementCounterValueUseCase;
  final DecrementCounterValueUseCase _decrementCounterValueUseCase;
  final ResetCounterValueUseCase _resetCounterValueUseCase;

  HomeCubit({
    required GetCounterValueUseCase getCounterValueUseCase,
    required IncrementCounterValueUseCase incrementCounterValueUseCase,
    required DecrementCounterValueUseCase decrementCounterValueUseCase,
    required ResetCounterValueUseCase resetCounterValueUseCase,
  })  : _getCounterValueUseCase = getCounterValueUseCase,
        _incrementCounterValueUseCase = incrementCounterValueUseCase,
        _decrementCounterValueUseCase = decrementCounterValueUseCase,
        _resetCounterValueUseCase = resetCounterValueUseCase,
        super(HomeState.initial());

  Future<void> getCounterValue() async {
    emit(state.copyWith(counterResult: LoadingState()));
    final result = await _getCounterValueUseCase.execute();
    emit(state.copyWith(counterResult: result));
  }

  Future<void> incrementValue() async {
    final result = await _incrementCounterValueUseCase.execute();
    emit(state.copyWith(counterResult: result));
  }

  Future<void> decrementValue() async {
    final result = await _decrementCounterValueUseCase.execute();
    emit(state.copyWith(counterResult: result));
  }

  Future<void> resetCounter() async {
    final result = await _resetCounterValueUseCase.execute();
    emit(state.copyWith(counterResult: result));
  }
}
