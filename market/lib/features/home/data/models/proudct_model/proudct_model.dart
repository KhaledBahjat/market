import 'favorite.dart';
import 'purchase.dart';

class ProudctModel {
  String? id;
  DateTime? createdAt;
  String? proudctName;
  String? proudctDesc;
  String? proudctPrice;
  String? oldPrice;
  String? proudcCategory;
  String? sale;
  dynamic imageUrls;
  List<Favorite>? favorite;
  List<Purchase>? purchase;

  ProudctModel({
    this.id,
    this.createdAt,
    this.proudctName,
    this.proudctDesc,
    this.proudctPrice,
    this.oldPrice,
    this.proudcCategory,
    this.sale,
    this.imageUrls,
    this.favorite,
    this.purchase,
  });

  factory ProudctModel.fromJson(Map<String, dynamic> json) => ProudctModel(
    id: json['id'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    proudctName: json['proudct_name'] as String?,
    proudctDesc: json['proudct_desc'] as String?,
    proudctPrice: json['proudct_price'] as String?,
    oldPrice: json['old_price'] as String?,
    proudcCategory: json['proudc_category'] as String?,
    sale: json['sale'] as String?,
    imageUrls: json['image_urls'] as dynamic,
    favorite: (json['favorite'] as List<dynamic>?)
        ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
        .toList(),
    purchase: (json['purchase'] as List<dynamic>?)
        ?.map((e) => Purchase.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'proudct_name': proudctName,
    'proudct_desc': proudctDesc,
    'proudct_price': proudctPrice,
    'old_price': oldPrice,
    'proudc_category': proudcCategory,
    'sale': sale,
    'image_urls': imageUrls,
    'favorite': favorite?.map((e) => e.toJson()).toList(),
    'purchase': purchase?.map((e) => e.toJson()).toList(),
  };
}
