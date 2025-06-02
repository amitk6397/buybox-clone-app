class OrderRequestModel {
  final String orderId;
  final String userId;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime timestamp;

  OrderRequestModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.timestamp,
  });

  factory OrderRequestModel.fromMap(Map<String, dynamic> json) {
    return OrderRequestModel(
      orderId: json['orderId'],
      userId: json['userId'],
      items:
          (json['items'] as List)
              .map((item) => OrderItem.fromMap(item))
              .toList(),
      total: json['total'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class OrderItem {
  final String itemId;
  final String name;
  final String image;
  final int quantity;
  final String price;

  OrderItem({
    required this.itemId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> json) {
    return OrderItem(
      itemId: json['itemId'],
      name: json['name'],
      image: json['image'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
