import 'package:bloc/bloc.dart';
import 'package:dummy_json/src/models/product_model.dart';
import 'package:dummy_json/src/services/x_services.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {

    on<FetchListProductEvent>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await ProductService().fetchListProduct(event.nameCategory);
      emit(result.fold(
            (l) => state.copyWith(status: ProductStatus.error, message: l),
            (r) => state.copyWith(
              category: event.nameCategory ?? '',
              status: ProductStatus.success,
              listProductModel: r,
            ),
      ),);
    });

    on<FetchListProductByPageEvent>((event, emit) async {
      final result = await ProductService().fetchListProductByPage(skip: event.skip, nameCategory: event.nameCategory);
      emit(result.fold(
            (l) => state.copyWith(message: l),
            (r) {
              var data = state.listProductModel!+r;
              return state.copyWith(
              listProductModel: data);
            },
      ),);
    });

    on<ShowSeeMore>((event, emit) => emit(state.copyWith(
        seeMore: event.value
    )));

    on<FetchDetailProductEvent>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await ProductService().fetchDetailProduct(id: event.id);
      emit(result.fold(
            (l) => state.copyWith(status: ProductStatus.error, message: l),
            (r) => state.copyWith(
              status: ProductStatus.success,
              detailProductModel: r,
            ),
      ),);
    });

    on<FetchListCategoryEvent>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final result = await ProductService().fetchListCategory();
      emit(result.fold(
            (l) => state.copyWith(status: ProductStatus.error, message: l),
            (r) => state.copyWith(
               status: ProductStatus.success,
               listCategory: r
            ),
      ));
    });
  }
}
