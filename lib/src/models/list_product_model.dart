part of 'x_models.dart';

class ListProductModel {
  List<ProductModel>? productListModel;
  int? total;
  int? skip;
  int? limit;

  ListProductModel({
    this.productListModel,
    this.total,
    this.skip,
    this.limit});

  ListProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      productListModel = <ProductModel>[];
      json['products'].forEach((v) {
        productListModel?.add(ProductModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}
