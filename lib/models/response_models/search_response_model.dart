class SearchResponseModel {
  String? status;
  String? requestId;
  Parameters? parameters;
  Data? data;

  SearchResponseModel({
    this.status,
    this.requestId,
    this.parameters,
    this.data,
  });

  SearchResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    requestId = json['request_id'];
    parameters =
        json['parameters'] != null
            ? new Parameters.fromJson(json['parameters'])
            : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Parameters {
  String? query;
  String? country;
  String? sortBy;
  int? page;

  Parameters({this.query, this.country, this.sortBy, this.page});

  Parameters.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    country = json['country'];
    sortBy = json['sort_by'];
    page = json['page'];
  }
}

class Data {
  int? totalProducts;
  String? country;
  String? domain;
  List<Products>? products;

  Data({this.totalProducts, this.country, this.domain, this.products});

  Data.fromJson(Map<String, dynamic> json) {
    totalProducts = json['total_products'];
    country = json['country'];
    domain = json['domain'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  String? asin;
  String? productTitle;
  String? productPrice;
  String? unitPrice;
  int? unitCount;
  String? productOriginalPrice;
  String? currency;
  String? productStarRating;
  int? productNumRatings;
  String? productUrl;
  String? productPhoto;
  int? productNumOffers;
  String? productMinimumOfferPrice;
  bool? isBestSeller;
  bool? isAmazonChoice;
  bool? isPrime;
  bool? climatePledgeFriendly;
  String? salesVolume;
  String? delivery;
  bool? hasVariations;
  String? productBadge;
  String? couponText;
  String? productByline;

  Products({
    this.asin,
    this.productTitle,
    this.productPrice,
    this.unitPrice,
    this.unitCount,
    this.productOriginalPrice,
    this.currency,
    this.productStarRating,
    this.productNumRatings,
    this.productUrl,
    this.productPhoto,
    this.productNumOffers,
    this.productMinimumOfferPrice,
    this.isBestSeller,
    this.isAmazonChoice,
    this.isPrime,
    this.climatePledgeFriendly,
    this.salesVolume,
    this.delivery,
    this.hasVariations,
    this.productBadge,
    this.couponText,
    this.productByline,
  });

  Products.fromJson(Map<String, dynamic> json) {
    asin = json['asin'];
    productTitle = json['product_title'];
    productPrice = json['product_price'];
    unitPrice = json['unit_price'];
    unitCount = json['unit_count'];
    productOriginalPrice = json['product_original_price'];
    currency = json['currency'];
    productStarRating = json['product_star_rating'];
    productNumRatings = json['product_num_ratings'];
    productUrl = json['product_url'];
    productPhoto = json['product_photo'];
    productNumOffers = json['product_num_offers'];
    productMinimumOfferPrice = json['product_minimum_offer_price'];
    isBestSeller = json['is_best_seller'];
    isAmazonChoice = json['is_amazon_choice'];
    isPrime = json['is_prime'];
    climatePledgeFriendly = json['climate_pledge_friendly'];
    salesVolume = json['sales_volume'];
    delivery = json['delivery'];
    hasVariations = json['has_variations'];
    productBadge = json['product_badge'];
    couponText = json['coupon_text'];
    productByline = json['product_byline'];
  }
}
