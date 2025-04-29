import 'package:base_flutter/src/data/preference/app_preference_source.dart';
import 'package:base_flutter/src/data/remote/counter/counter_api_source.dart';
import 'package:base_flutter/src/domain/entities/result.dart';
import 'package:base_flutter/src/domain/repository/counter_repository.dart';

class CounterRepositoryImpl extends CounterRepository {
  final CounterApiSource _counterApiSource;
  final AppPreferenceSource _appPreferenceSource;

  CounterRepositoryImpl({
    required CounterApiSource counterApiSource,
    required AppPreferenceSource appPreferenceSource,
  })  : _counterApiSource = counterApiSource,
        _appPreferenceSource = appPreferenceSource;

  @override
  Future<Result<int>> getCounterValue() async {
    final current = await _appPreferenceSource.getCounter();
    final result = await _counterApiSource.getCounterValue();
    // if error return data from local storage
    if (result is! SuccessState<int>) return SuccessState(data: current);
    // update server with data from local storage
    if (current != result.data) {
      return await _counterApiSource.updateCounterValue(value: current);
    }
    return result;
  }

  @override
  Future<Result<int>> incrementValue() async {
    final value = (await _appPreferenceSource.getCounter()) + 1;
    await _appPreferenceSource.updateCounter(value);
    return SuccessState(data: value);
  }

  @override
  Future<Result<int>> decrementValue() async {
    final value = (await _appPreferenceSource.getCounter()) - 1;
    await _appPreferenceSource.updateCounter(value);
    return SuccessState(data: value);
  }

  @override
  Future<Result<int>> updateCounterValue({required int value}) async {
    await _appPreferenceSource.updateCounter(value);
    return SuccessState(data: await _appPreferenceSource.getCounter());
  }
}
