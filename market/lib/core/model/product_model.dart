class ProductModel {
	final String proudctId;
	final DateTime createdAt;
	final String proudctName;
	final String proudctPrice;
	final String oldPrice;
	final String sale;
	final String desc;
	final String category;
	final String? imageUrl;
	final List<FavoriteModel> favorite;
	final List<PurchaseModel> purchase;

	ProductModel({
		required this.proudctId,
		required this.createdAt,
		required this.proudctName,
		required this.proudctPrice,
		required this.oldPrice,
		required this.sale,
		required this.desc,
		required this.category,
		required this.imageUrl,
		required this.favorite,
		required this.purchase,
	});

	factory ProductModel.fromJson(Map<String, dynamic> json) {
		return ProductModel(
			proudctId: json['proudct_id'] as String,
			createdAt: DateTime.parse(json['created_at'] as String),
			proudctName: json['proudct_name'] as String,
			proudctPrice: json['proudct_price'] as String,
			oldPrice: json['old_price'] as String,
			sale: json['sale'] as String,
			desc: json['desc'] as String,
			category: json['category'] as String,
			imageUrl: json['image_url'] as String?,
			favorite: (json['favorite'] as List<dynamic>? ?? [])
					.map((item) => FavoriteModel.fromJson(item as Map<String, dynamic>))
					.toList(),
			purchase: (json['purchase'] as List<dynamic>? ?? [])
					.map((item) => PurchaseModel.fromJson(item as Map<String, dynamic>))
					.toList(),
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'proudct_id': proudctId,
			'created_at': createdAt.toIso8601String(),
			'proudct_name': proudctName,
			'proudct_price': proudctPrice,
			'old_price': oldPrice,
			'sale': sale,
			'desc': desc,
			'category': category,
			'image_url': imageUrl,
			'favorite': favorite.map((item) => item.toJson()).toList(),
			'purchase': purchase.map((item) => item.toJson()).toList(),
		};
	}
}

class FavoriteModel {
	final String id;
	final String forUser;
	final DateTime createdAt;
	final String forProduct;
	final bool isFavorite;

	FavoriteModel({
		required this.id,
		required this.forUser,
		required this.createdAt,
		required this.forProduct,
		required this.isFavorite,
	});

	factory FavoriteModel.fromJson(Map<String, dynamic> json) {
		return FavoriteModel(
			id: json['id'] as String,
			forUser: json['for_user'] as String,
			createdAt: DateTime.parse(json['created_at'] as String),
			forProduct: json['for_product'] as String,
			isFavorite: json['is_favorite'] as bool,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'for_user': forUser,
			'created_at': createdAt.toIso8601String(),
			'for_product': forProduct,
			'is_favorite': isFavorite,
		};
	}
}

class PurchaseModel {
	final String id;
	final String forUser;
	final bool isBought;
	final DateTime createdAt;
	final String forProduct;

	PurchaseModel({
		required this.id,
		required this.forUser,
		required this.isBought,
		required this.createdAt,
		required this.forProduct,
	});

	factory PurchaseModel.fromJson(Map<String, dynamic> json) {
		return PurchaseModel(
			id: json['id'] as String,
			forUser: json['for_user'] as String,
			isBought: json['is_bought'] as bool,
			createdAt: DateTime.parse(json['created_at'] as String),
			forProduct: json['for_product'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'for_user': forUser,
			'is_bought': isBought,
			'created_at': createdAt.toIso8601String(),
			'for_product': forProduct,
		};
	}
}