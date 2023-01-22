import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../DataLayer/Repository/UserRepository/UserRepository.dart';
import '../Widget/CurveWidgetStaff.dart';
import '../Widget/curveWidget.dart';
import 'Admin/BottomNavBar/NavBarAdmin.dart';
import 'Register.dart';
import 'Staff/BottomNavBar/NavBarStaff.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            /// Navigating to the dashboard screen if the user is authenticated
            ///but if no internet connection
            ///cant access this app
            try {
              bool result = await InternetConnectionChecker().hasConnection;
              if (result == true) {
                await checkUserLogin(context);
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('No Internet Connection'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            } catch (e) {}
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthenticated) {
            return Container(
              height: double.infinity,
              color: Colors.white,
              child: ListView(children: [
                Stack(
                  children: const [
                    CurveWidget(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Welcome to AdvanceCalLab',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 52, 84)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.20,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          _usernameField(),
                          const SizedBox(
                            height: 10,
                          ),
                          _passwordField(),
                          const SizedBox(
                            height: 100,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Material(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromARGB(255, 64, 224, 208),
                                        Colors.blue,
                                      ],
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _authenticateWithEmailAndPassword(
                                          context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Colors.transparent,
                                        fixedSize: const Size(300, 60),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    child: const Text('Sign In'),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Not a Member? '),
                              GestureDetector(
                                child: const Text('Register',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue)),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Register()),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ]),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget _usernameField() {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        //hintText: 'Username',
        hintText: 'email',
        hintStyle: TextStyle(color: Colors.black54),
        icon: Icon(
          Icons.person,
          color: Colors.black,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value != null && !EmailValidator.validate(value)
            ? 'Enter a valid email'
            : null;
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black54),
          hintText: 'password',
          icon: Icon(
            Icons.security,
            color: Colors.black,
          )),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const AdminEquipmentForm()));//temporary home
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.green,
          fixedSize: const Size(300, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text('Login'),
    );
  }

  void _authenticateWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }
}

///to check if user or admin
checkUserLogin(context) async {
  bool userStatus = await checkUserStatus();
  switch (userStatus) {
    case false:
      {
        print("user status if is true: $userStatus");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const NavBarStaff()));
      }
      break;
    default:
      {
        print("user status if is false: $userStatus");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const NavBarAdmin()));
      }
  }
}

checkUserStatus() async {
  String? email = FirebaseAuth.instance.currentUser?.email;
  return UserRepository().checkUser(email!);
}
