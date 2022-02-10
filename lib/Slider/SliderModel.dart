// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    required this.status,
    required this.sliders,
    required this.sliderBanners,
    required this.bestSeller,
  });

  String status;
  List<Slider> sliders;
  List<SliderBanner> sliderBanners;
  List<BestSeller> bestSeller;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        sliders:
            List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
        sliderBanners: List<SliderBanner>.from(
            json["slider_banners"].map((x) => SliderBanner.fromJson(x))),
        bestSeller: List<BestSeller>.from(
            json["best_seller"].map((x) => BestSeller.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
        "slider_banners":
            List<dynamic>.from(sliderBanners.map((x) => x.toJson())),
        "best_seller": List<dynamic>.from(bestSeller.map((x) => x.toJson())),
      };
}

class BestSeller {
  BestSeller({
    required this.id,
    required this.name,
    required this.price,
    required this.salePrice,
    required this.slug,
    required this.discount,
    required this.thumnail,
  });

  int id;
  String name;
  String price;
  String salePrice;
  String slug;
  int discount;
  String thumnail;

  factory BestSeller.fromJson(Map<String, dynamic> json) => BestSeller(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        salePrice: json["sale_price"],
        slug: json["slug"],
        discount: json["discount"],
        thumnail: json["thumnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "sale_price": salePrice,
        "slug": slug,
        "discount": discount,
        "thumnail": thumnail,
      };
}

class SliderBanner {
  SliderBanner({
    required this.id,
    required this.url,
    required this.banner,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String url;
  String banner;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory SliderBanner.fromJson(Map<String, dynamic> json) => SliderBanner(
        id: json["id"],
        url: json["url"],
        banner: json["banner"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "banner": banner,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Slider {
  Slider({
    required this.id,
    required this.image,
    required this.url,
    required this.sliderCaption,
    required this.status,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String image;
  String url;
  dynamic sliderCaption;
  int status;
  dynamic position;
  DateTime createdAt;
  DateTime updatedAt;

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        image: json["image"],
        url: json["url"],
        sliderCaption: json["slider_caption"],
        status: json["status"],
        position: json["position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "url": url,
        "slider_caption": sliderCaption,
        "status": status,
        "position": position,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
