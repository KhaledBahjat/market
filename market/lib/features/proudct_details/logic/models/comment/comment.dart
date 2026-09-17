class Comment {
  String? id;
  DateTime? createdAt;
  String? comment;
  String? forUser;
  String? forProudct;
  String? userName;
  dynamic replay;

  Comment({
    this.id,
    this.createdAt,
    this.comment,
    this.forUser,
    this.forProudct,
    this.userName,
    this.replay,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json['id'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    comment: json['comment'] as String?,
    forUser: json['for_user'] as String?,
    forProudct: json['for_proudct'] as String?,
    userName: json['user_name'] as String?,
    replay: json['replay'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'comment': comment,
    'for_user': forUser,
    'for_proudct': forProudct,
    'user_name': userName,
    'replay': replay,
  };
}
