// created Saturday 17/12/22

part of 'x_services.dart';

class UserService {
  Response? response;
  var dio = Dio();

  Future<Either<String, UserModel>> loginUser(
      {String? username, String? password}) async {
    try {
      response = await dio.post(
        '${baseUrl}auth/login',
        options: Options(
          headers: {
            Headers.contentTypeHeader: headerUrl, // set content-length
          },
        ),
        data: {
          'username': '$username',
          'password': '$password',
        },
      );
      if (response!.data.isNotEmpty) {
        return right(UserModel.fromJson(response!.data));
      } else {
        return left('${response?.statusMessage}');
      }
    } catch (e) {
      return left(e.toString().split(']').last);
    }
  }

}
