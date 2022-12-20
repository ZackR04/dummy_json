// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { initial, success, error, loading }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isSuccess => this == ProductStatus.success;
  bool get isError => this == ProductStatus.error;
  bool get isLoading => this == ProductStatus.loading;
}

class ProductState extends Equatable {
  final ProductStatus status;
  final String? message;
  final List<ProductModel>? listProductModel;
  final int? total;
  final int? skip;
  final int? limit;
  final ProductModel? detailProductModel;
  final bool? seeMore;
  final List<String>? listCategory;
  final String? category;

  const ProductState({
    this.status = ProductStatus.initial,
    this.message,
    this.listProductModel,
    this.total,
    this.skip,
    this.limit,
    this.detailProductModel,
    this.seeMore,
    this.listCategory,
    this.category,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        listProductModel,
        total,
        skip,
        limit,
        detailProductModel,
        seeMore,
        listCategory,
        category,
      ];

  ProductState copyWith({
    ProductStatus? status,
    String? message,
    List<ProductModel>? listProductModel,
    int? total,
    int? skip,
    int? limit,
    ProductModel? detailProductModel,
    bool? seeMore,
    List<String>? listCategory,
    String? category,
  }) {
    return ProductState(
      status: status ?? this.status,
      message: message ?? this.message,
      listProductModel: listProductModel ?? this.listProductModel,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
      detailProductModel: detailProductModel ?? this.detailProductModel,
      seeMore: seeMore ?? this.seeMore,
      listCategory: listCategory ?? this.listCategory,
      category: category ?? this.category,
    );
  }
}
