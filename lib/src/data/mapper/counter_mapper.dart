class CounterMapper {
  static int mapToDomain(Map<String, dynamic> json) {
    return json["current_value"];
  }
}
