class LearnTopic {
  int? id;
  String? key;
  String? name;

  LearnTopic({
    this.id,
    this.key,
    this.name,
  });

  factory LearnTopic.fromJson(Map<String, dynamic> json) {
    return LearnTopic(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }
}
