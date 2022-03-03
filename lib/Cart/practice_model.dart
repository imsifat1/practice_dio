import 'dart:convert';

class PracticeModel {
  String? cartTotal;
  List<ProductModel>? cartContent;
  int? itemCount;
  PracticeModel({this.cartTotal, this.cartContent, this.itemCount});
  factory PracticeModel.fromJson(String data) {
    Map<String, dynamic> dataMap = json.decode(data);
    return PracticeModel(
        cartTotal: dataMap["cart_total"],
        cartContent: dataMap['cart_content'].values.map<ProductModel>((item) {
          return ProductModel.fromJson(item as Map<String, dynamic>);
        }).toList(),
        itemCount: dataMap['item_count']);
  }
  @override
  String toString() {
    // TODO: implement toString
    return ' $cartTotal $cartContent $itemCount ';
  }
}

class ProductModel {
  String? name;
  String? qty;
  int? price;
  Options? options;
  ProductModel({this.name, this.qty, this.price, this.options});
  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
        name: data['name'],
        qty: data['qty'],
        price: data['price'],
        options: data['options'].values.map<Options>((item) {
          return Options.fromJson(item as Map<String, dynamic>);
        }).toList());
  }
  @override
  String toString() {
    // TODO: implement toString
    return '$name $qty $price';
  }
}

class Options {
  String? variantId;
  Options({this.variantId});
  factory Options.fromJson(Map<String, dynamic> data) {
    return Options(variantId: data['variant_id']);
  }
  @override
  String toString() {
    // TODO: implement toString
    return "$variantId";
  }
}
