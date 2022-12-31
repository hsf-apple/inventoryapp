import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huawei_safetydetect/huawei_safetydetect.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/About/Password/AdminChangePasswordScreen.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/About/Profile/AdminProfileScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../Login.dart';

class AboutScreenAdmin extends StatefulWidget {
  const AboutScreenAdmin({Key? key}) : super(key: key);

  @override
  State<AboutScreenAdmin> createState() => _AboutScreenAdminState();
}

class _AboutScreenAdminState extends State<AboutScreenAdmin> {

  getMaliciousAppsList(BuildContext context) {
    runZoned(() async {
      List<MaliciousAppData> maliciousApps;
      maliciousApps = await SafetyDetect.getMaliciousAppsList();
      String maliciousAppsResult = maliciousApps.isEmpty
          ? "No malicious apps detected."
          : "Malicious Apps:$maliciousApps";
      if (kDebugMode) {
        print(maliciousAppsResult);
      }
      showSuccessAlert(context, maliciousAppsResult);
    }, onError: (error, stackTrace) {

      showErrorAlert(context, error.toString());
    });
  }

  showSuccessAlert(BuildContext context, String message) {
    Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
  showErrorAlert(BuildContext context, String message) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Error",
      desc: message,
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  final providerID = FirebaseAuth.instance.currentUser!.providerData.first.providerId;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('About'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false,
              );
            }
          },
          child:ListView(
            children:  [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const AdminProfileScreen()),

                  );
                },
                child: const Card(
                  child: ListTile(title: Text('Profile'),),
                ),
              ),//user profile
              userListView(providerID,context),//change password
              GestureDetector(
                onTap: (){
                  _showDialog(context);
                },
                child: const Card(
                  child: ListTile(title: Text('Logout'),),
                ),
              )//logout

            ],
          ), ),

      ),

      ),
    );
  }
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Expanded(
              child: AlertDialog(
                title: const Text('Log Out'),
                content: const Text('Do you  want to Log Out?'),
                actions: [
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).pop();
                    },
                    child: const Text('NO', style: TextStyle(color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {
                      // Signing out the user
                      context.read<AuthBloc>().add(SignOutRequested());
                      //Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const Login()),
                              (Route<dynamic> route) => false);
                    },
                    child: const Text('YES', style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

Widget userListView(providerID,context)
{
  if (providerID == "password")
  {
    return  GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const AdminChangePasswordScreen()),

        );
      },
      child: const Card(
        child: ListTile(title: Text('Change Password'),),
      ),
    );//change password;
  }
  else
  {
    return Container();
  }
}