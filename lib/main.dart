import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BusinessLayer/AuthBloc/auth_bloc.dart';
import 'DataLayer/Repository/AuthenticationRepository/AuthRepository.dart';
import 'PresentationLayer/Screens/Admin/AdminEquipmentForm.dart';
import 'PresentationLayer/Screens/Login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.green,
            ),
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return FutureBuilder(
                      future: internetCheck(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.hasData){
                            return const AdminEquipmentForm();
                          }else{
                            return Login();
                          }
                        }else{
                          return Container(decoration: const BoxDecoration(
                            color: Colors.green,
                          ),);
                        }
                      }
                  );
                }
                return Login();
              },
            ),
          ),
        )
    );

    // return RepositoryProvider(
    //   create: (context) => AuthRepository(),
    //   child: BlocProvider(
    //     create: (context) => AuthBloc(
    //       authRepository: RepositoryProvider.of<AuthRepository>(context),
    //     ),
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false ,
    //       title: 'Self-Task Student',
    //       theme: ThemeData(
    //         primaryColor: Colors.green,
    //       ),
    //       home: Login(),
    //     ),
    //   ),
    // );
  }

  Future<bool?> internetCheck() async {
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return null;
    }
  }
}
