
class TestPreparation{
  int? id;
  String? key;
  String? name;

  TestPreparation({
    this.id,
    this.key,
    this.name,
  });

  factory TestPreparation.fromJson(Map<String, dynamic> json) {
    return TestPreparation(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}
