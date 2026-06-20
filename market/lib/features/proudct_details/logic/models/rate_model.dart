class RateModel {
  final String?id;
  final String? forUser;
  final String ?forProduct;
  final int? rate;
  final DateTime? createdAt;

  RateModel(this.id, this.forUser, this.forProduct, this.rate, this.createdAt);

  factory RateModel.fromJson(Map<String, dynamic> json) {
    return RateModel(
      json['id'] as String?,
      json['for_user'] as String?,
      json['for_product'] as String?,
      json['rate'] as int?,
      DateTime.parse(json['created_at'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
  
}