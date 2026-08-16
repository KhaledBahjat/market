class Purchase {
  String? id;
  String? forUser;
  bool? isBought;
  DateTime? createdAt;
  String? forProudct;

  Purchase({
    this.id,
    this.forUser,
    this.isBought,
    this.createdAt,
    this.forProudct,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    id: json['id'] as String?,
    forUser: json['for_user'] as String?,
    isBought: json['is_bought'] as bool?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    forProudct: json['for_proudct'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'for_user': forUser,
    'is_bought': isBought,
    'created_at': createdAt?.toIso8601String(),
    'for_proudct': forProudct,
  };
}
