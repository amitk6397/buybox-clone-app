// models/fruit_model.dart
class FruitsResponseModel {
  final String title;
  final String price;
  final String piece;

  FruitsResponseModel({
    required this.title,
    required this.price,
    required this.piece,
  });

  factory FruitsResponseModel.fromJson(Map<String, dynamic> json) {
    return FruitsResponseModel(
      title: json['title'],
      price: json['price'],
      piece: json['piece'],
    );
  }
}
