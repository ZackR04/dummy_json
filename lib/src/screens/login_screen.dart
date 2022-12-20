part of 'x_screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 28, left: 20, right: 20),
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(
                height: 40,
              ),
              _buildFormLogin(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Expanded(
      child: SvgPicture.asset('assets/images/login.svg'),
    );
  }

  Widget _buildFormLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          TextFieldWidget(
            controller: userController,
            title: 'Username',
            hint: 'Input Username',
          ),
          const SizedBox(
            height: 16,
          ),
          TextFieldWidget(
            controller: passController,
            title: 'Password',
            hint: 'Input Password',
            isPassword: true,
          ),
          const SizedBox(
            height: 40,
          ),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.go(pageName.home);
              }
            },
            builder: (context, state) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/16,
                    width: MediaQuery.of(context).size.width,
                    child: MaterialButton(
                        color: ColorName.deepGrey,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(
                            username: userController.text,
                            password: passController.text,
                          ));
                        },
                        child: const Text('LOG IN', style: TextStyle(fontSize: 20, color: Colors.white))),
                  )
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<LoginBloc>(context).add(LoadUserDateEvent());
              context.go(pageName.home);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.arrow_back_rounded),
                SizedBox(
                  width: 4,
                ),
                Text('Back to Home'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
