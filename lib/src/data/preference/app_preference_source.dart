abstract class AppPreferenceSource {
  Future<void> updateCounter(int count);

  Future<int> getCounter();
}
