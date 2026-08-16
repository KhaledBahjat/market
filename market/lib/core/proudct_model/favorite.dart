class Favorite {
  String? id;
  String? forUser;
  DateTime? createdAt;
  String? forProudct;
  bool? isFavorite;

  Favorite({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProudct,
    this.isFavorite,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json['id'] as String?,
    forUser: json['for_user'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    forProudct: json['for_proudct'] as String?,
    isFavorite: json['is_favorite'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'for_user': forUser,
    'created_at': createdAt?.toIso8601String(),
    'for_proudct': forProudct,
    'is_favorite': isFavorite,
  };
}
