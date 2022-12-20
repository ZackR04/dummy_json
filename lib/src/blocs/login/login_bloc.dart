import 'package:bloc/bloc.dart';
import 'package:dummy_json/src/services/x_services.dart';
import 'package:dummy_json/src/utilities/x_utilities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {

    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(
        status: LoginStatus.loading
      ));
      final result = await UserService().loginUser(username: event.username, password: event.password);
      emit(
        result.fold(
              (l) => state.copyWith(
                  status: LoginStatus.error,
                  message: l),
              (r) {
                Commons().setPrefs(r);
                return state.copyWith(
                status: LoginStatus.success,
                );
              },
        ),
      );
    });

    on<LoadUserDateEvent>((event, emit) async {
      emit(state.copyWith(
        status: LoginStatus.loading
      ));
      var data = await Commons().getPrefs();
      emit(state.copyWith(
        status: LoginStatus.success,
        username: data.username,
        image: data.image,
        id: data.id,
        email: data.email,
        token: data.token,
      ));
    });
  }
}
