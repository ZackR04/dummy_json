part of 'x_services.dart';

class ProductService {
  Response? response;
  var dio = Dio();

  Future<Either<String, List<ProductModel>>> fetchListProduct(String? nameCategory) async {
    try {
      response = await dio.get('${baseUrl}products${nameCategory != null ? nameCategory == '/category/All/' ? '' : nameCategory : ''}?limit=8');
      if (response != null) {
        var data = ListProductModel.fromJson(response!.data);
        return right(data.productListModel!);
      } else {
        return left('${response?.statusMessage}');
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<ProductModel>>> fetchListProductByPage({required int skip, String? nameCategory}) async {
    try {
      response = await dio.get('${baseUrl}products${nameCategory != null ? nameCategory == '/category/All/' ? '' : nameCategory : ''}?limit=8&skip=$skip');
      if (response != null) {
        var data = ListProductModel.fromJson(response!.data);
        return right(data.productListModel!);
      } else {
        return left('${response?.statusMessage}');
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, ProductModel>> fetchDetailProduct({required int id}) async {
    try {
      response = await dio.get('${baseUrl}products/$id');
      if (response != null) {
        var data = ProductModel.fromJson(response!.data);
        return right(data);
      } else {
        return left('${response?.statusMessage}');
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<String>>> fetchListCategory() async {
    try {
      response = await dio.get('${baseUrl}products/categories');
      if (response != null) {
        var data = <String>[];
        for(
        int i=0; i<response!.data!.length; i++
        ) {
          data.add('${response!.data[i]}');
        }
        data.insert(0, 'All');
        return right(data);
      } else {
        return left('${response?.statusMessage}');
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
