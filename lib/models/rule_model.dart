import 'dart:convert';

class Rule {
  late num id;
  late String name;
  late num active;
  late num order;

  Rule(
      {required this.active,
      required this.id,
      required this.name,
      required this.order});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'active': active,
    };
  }

  factory Rule.fromMap(Map<String, dynamic> map) {
    return Rule(
      id: map['id'] as num,
      name: map['name'] as String,
      active: map['active'] as num,
      order: map['order'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rule.fromJson(String source) =>
      Rule.fromMap(json.decode(source) as Map<String, dynamic>);
}
