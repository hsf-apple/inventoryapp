import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../DataLayer/Model/UserModel/userModel.dart';
import '../../DataLayer/Repository/UserRepository/UserRepository.dart';
import 'Admin/AdminEquipmentForm.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Register();
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _userID = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _userID.dispose();
    _rePasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:const BackButton(color: Colors.black),

        title: const Text('Register', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const AdminEquipmentForm(),
              ),
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Displaying the sign up form if the user is not authenticated
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 0, 20, 20),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _email(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // _IDinput(),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  _password(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _rePassword(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _fullName(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  _phoneNumber(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: ElevatedButton(
                                      onPressed: () {

                                        if(_formKey.currentState!.validate())
                                        {
                                          _formKey.currentState!.save();
                                          UserRepository userRepository = UserRepository();
                                          UserModel userModel = UserModel(
                                            name: _fullNameController.text,
                                            email: _emailController.text,
                                            telNumber: _phoneNumberController.text,
                                          );
                                          userRepository.addUser(userModel, _emailController.text);
                                          _createAccountWithEmailAndPassword(context);
                                        }

                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(255, 0, 199, 140),
                                          fixedSize: const Size(300, 60),
                                          shape:
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                      child: const Text('Sign Up'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      )
                      // Padding(
                      //     padding:
                      //     const EdgeInsets.symmetric(horizontal: 20),
                      //     child: )

                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _fullName() {
    return TextFormField(
       controller: _fullNameController,
      validator: (value){
        if(value == null || value.isEmpty){
          return "Enter your Full Name";
        }
      },
      decoration: const InputDecoration(
        hintText: 'Full Name',
      ),
      onSaved: (val) => _fullNameController.text = val!,
    );
  }

  Widget _email() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
          hintText: "Email"
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your email';
        }

        return null;
      },
      onSaved: (val) => _emailController.text = val!,
    );
  }

  Widget _phoneNumber() {
    return TextFormField(
      controller: _phoneNumberController,
      validator: (value){
        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = RegExp(pattern);
        if(value == null || value.isEmpty){
          return "Enter your phone number";
        }
        else if (!regExp.hasMatch(value)) {
          return 'Please enter valid phone number';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Phone number',
      ),
      onSaved: (val) => _phoneNumberController.text = val!,
    );
  }

  Widget _IDinput() {
    return TextFormField(
      controller: _userID,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'User ID',
      ),
    );
  }

  Widget _password() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value != null && value.length < 6
            ? "Enter min. of 6 characters"
            : null;
      },
    );
  }

  Widget _rePassword() {
    return TextFormField(
      controller: _rePasswordController,
      validator: (value){
        if(value == null || value.isEmpty){
          return "Enter your password";
        }
        return _passwordController.text == value ? null : "The password is not the same";
      },
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Re-Password',
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Register()));
      },
      style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 0, 199, 140),
          fixedSize: const Size(300, 60),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: const Text('Register'),
    );
  }

  void _createAccountWithEmailAndPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(
          _emailController.text,
          _passwordController.text,
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
