import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    required this.data,
  });

  List<RestaurantData> data;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    data: List<RestaurantData>.from(json["data"].map((x) => RestaurantData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RestaurantData {
  RestaurantData({
    required this.id,
    required this.attributes,
  });

  int id;
  DatumAttributes attributes;

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    id: json["id"],
    attributes: DatumAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes.toJson(),
  };
}

class DatumAttributes {
  DatumAttributes({
    required this.name,
    required this.category,
    required this.discount,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.picture,
  });

  String name;
  String category;
  int discount;
  double deliveryFee;
  int deliveryTime;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime publishedAt;
  Picture picture;

  factory DatumAttributes.fromJson(Map<String, dynamic> json) => DatumAttributes(
    name: json["name"],
    category: json["category"],
    discount: json["discount"],
    deliveryFee: json["deliveryFee"]?.toDouble(),
    deliveryTime: json["deliveryTime"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    publishedAt: DateTime.parse(json["publishedAt"]),
    picture: Picture.fromJson(json["picture"]),
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
    "picture": picture.toJson(),
  };
}

class Picture {
  Picture({
    required this.data,
  });

  Data data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
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
  DataAttributes attributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    attributes: DataAttributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attributes": attributes.toJson(),
  };
}

class DataAttributes {
  DataAttributes({
    required this.url,
  });

  String url;

  factory DataAttributes.fromJson(Map<String, dynamic> json) => DataAttributes(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}