import 'dart:convert';

RestaurantPostResponse restaurantPostResponseFromJson(String str) => RestaurantPostResponse.fromJson(json.decode(str));

String restaurantPostResponseToJson(RestaurantPostResponse data) => json.encode(data.toJson());

class RestaurantPostResponse {
  RestaurantPostResponse({
    required this.data,
  });

  Data data;

  factory RestaurantPostResponse.fromJson(Map<String, dynamic> json) => RestaurantPostResponse(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.attributes,
  });

  int id;
  Attributes attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  Attributes({
    required this.name,
    required this.category,
    required this.discount,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  String name;
  String category;
  int discount;
  double deliveryFee;
  int deliveryTime;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    name: json["name"],
    category: json["category"],
    discount: json["discount"],
    deliveryFee: json["deliveryFee"]?.toDouble(),
    deliveryTime: json["deliveryTime"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category": category,
    "discount": discount,
    "deliveryFee": deliveryFee,
    "deliveryTime": deliveryTime,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "publishedAt": publishedAt.toIso8601String(),
  };
}
