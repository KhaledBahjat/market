class Populare {
  int? id;
  DateTime? createdAt;
  List<String>? images;

  Populare({this.id, this.createdAt, this.images});

  factory Populare.fromJson(Map<String, dynamic> json) => Populare(
    id: json['id'] as int?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    images: json['images'] as List<String>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'images': images,
  };
}
