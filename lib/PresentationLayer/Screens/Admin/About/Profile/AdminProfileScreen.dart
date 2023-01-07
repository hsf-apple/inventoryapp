import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../BusinessLayer/Manage User/user_bloc.dart';
import '../../../../../DataLayer/Model/UserModel/userModel.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  //declare bloc
  final UserBloc userBloc = UserBloc();

  //form
  final _formKey = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser!;
  final providerID = FirebaseAuth.instance.currentUser!.providerData.first.providerId;


  String nameFinal = "" ;
  String emailFinal = "" ;
  String phoneNoFinal = "" ;
  TextEditingController verPassword = TextEditingController();


  @override
  void initState() {
    String? email = FirebaseAuth.instance.currentUser?.email;
    userBloc.add(GetUser(email!));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body:  BlocProvider(
          create: (_) => userBloc,
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              //kt sini add user data
              state.userdata.telNumber!;

              user.email!;

              return Center(
                child:  SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),child:Center(child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  nameField( state.userdata.name!),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  noTelField(state.userdata.telNumber!),
                                  const SizedBox(height: 15),
                                  emailField(state.userdata.email!),
                                  const SizedBox(height: 15),
                                  verifyPasswordField(),
                                  const SizedBox(height: 15),
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
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
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try{
                                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                              email: user.email!,
                                              password: verPassword.text,
                                            );

                                            _formKey.currentState!.save();

                                            user.updateEmail(emailFinal).then((_){
                                              UserModel usermod = UserModel(
                                                email: emailFinal,
                                                name:  nameFinal,
                                                telNumber: phoneNoFinal,
                                                isAdmin: true,

                                              );

                                              //insert data using bloc
                                              userBloc.add(UpdateUser(usermod,user.email!));

                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content:
                                                  Text('Data Updated Successfully'),
                                                ),
                                              );
                                              Navigator.pop(context);
                                            }).catchError((error){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Please enter your valid password'))
                                              );

                                              if (kDebugMode) {
                                                print("Email can't be changed$error");
                                              }
                                              //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                                            });
                                          }on FirebaseAuthException catch (e) {
                                            if (e.code == 'user-not-found') {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('No user found'),
                                                    backgroundColor: Colors.red,
                                                  )
                                              );
                                            } else if (e.code == 'wrong-password') {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Wrong password provided'),
                                                    backgroundColor: Colors.red,
                                                  )
                                              );
                                            }
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          fixedSize: const Size(300, 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25))),
                                      child: const Text('Confirm'),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ))) ,)

                    ],
                  ),
                ),
              );



            }else
            {
              return const Text('');
            }

          }
          ),
        ),),
    );
  }

  Widget nameField(String name) {
    return TextFormField(
      initialValue: name,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Full Name'),
      ),
      onSaved: (val) => nameFinal = val!,
    );
  }

  Widget noTelField(String noTel) {
    return TextFormField(
      initialValue: noTel,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Phone Number'),
      ),
      onSaved: (val) => phoneNoFinal = val!,
    );
  }

  Widget emailField(String email) {
    return TextFormField(
      initialValue: email,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Phone Number'),
      ),
      onSaved: (val) => emailFinal = val!,
    );
  }

  Widget verifyPasswordField() {
    return TextFormField(
      controller: verPassword,
      obscureText: true,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Verify Password',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password before adding profile information.';
        }

        return null;
      },
      onSaved: (val) => verPassword.text = val!,
    );
  }
}
