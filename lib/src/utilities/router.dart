part of 'x_utilities.dart';

mixin pageName {
  static const login = '/login';
  static const home = '/home';
//
  static const detail = 'detail';
  static const detailPath = '/home/detail';
  // static const cart = 'cart';
  // static const cartPath ='/home/detail/cart';
}

final GoRouter router = GoRouter(
  initialLocation: pageName.home,
  routes: [
    GoRoute(
      path: pageName.login,
      builder: ((context, state) => const LoginScreen()),
    ),
    GoRoute(
        path: pageName.home,
        builder: ((context, state) {
          BlocProvider.of<LoginBloc>(context).add(LoadUserDateEvent());
          return const HomeScreen();
        }),
        routes: [
          GoRoute(
              path: pageName.detail,
              builder: ((context, state) {
                int id = state.extra as int;
                return DetailProductScreen(id: id);
              }),
              // routes: [
              //   GoRoute(
              //     path: pageName.cart,
              //     builder: ((context, state) => const CartScreen()),
              //   ),
              // ]
          ),
        ],
    ),
  ],
);
