import 'package:dummy_json/src/blocs/x_blocs.dart';
import 'utilities/x_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider (create: (BuildContext context) => ProductBloc()),
        BlocProvider (create: (BuildContext context) => LoginBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
