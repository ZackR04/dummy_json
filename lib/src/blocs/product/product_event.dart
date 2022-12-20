part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class FetchListProductEvent extends ProductEvent {
  final String? nameCategory;

  FetchListProductEvent({this.nameCategory});

  @override
  // TODO: implement props
  List<Object?> get props => [nameCategory];
}

class FetchListProductByPageEvent extends ProductEvent {
  // final int limit;
  final int skip;
  final String? nameCategory;

  FetchListProductByPageEvent({
    // required this.limit,
    required this.skip,
    this.nameCategory,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    // limit,
    skip,
    nameCategory,
  ];
}

class ShowSeeMore extends ProductEvent {
  final bool? value;

  ShowSeeMore(this.value);

  @override
  // TODO: implement props
  List<Object?> get props => [value];
}

class FetchDetailProductEvent extends ProductEvent {
  final int id;

  FetchDetailProductEvent({
    required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchListCategoryEvent extends ProductEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
