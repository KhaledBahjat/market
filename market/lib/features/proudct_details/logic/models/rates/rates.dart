class Rates {
  String? id;
  DateTime? createdAt;
  int? rate;
  String? forUser;
  String? forProudct;

  Rates({
    this.id,
    this.createdAt,
    this.rate,
    this.forUser,
    this.forProudct,
  });

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
    id: json['id'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    rate: json['rate'] as int?,
    forUser: json['for_user'] as String?,
    forProudct: json['for_proudct'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'rate': rate,
    'for_user': forUser,
    'for_proudct': forProudct,
  };
}
