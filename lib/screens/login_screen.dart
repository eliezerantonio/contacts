import 'package:animate_do/animate_do.dart';
import 'package:contacts/models/user_manager.dart';
import 'package:contacts/widgets/custom_textformfield.dart';
import 'package:contacts/widgets/show_alert.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final userController = TextEditingController();
final passControlller = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              body(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return FadeInLeft(
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
        SizedBox(
          height: 17,
        ),
        Text("Login",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 7,
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed finge non solum",
        ),
        SizedBox(
          height: 30,
        ),
      ]),
    );
  }

  Widget body(BuildContext context) {
    return FadeInRight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Username",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            hintText: 'example',
            controller: userController,
          ),
          const SizedBox(height: 20),
          const Text(
            "Password",
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            hintText: '******',
            isPassword: true,
            controller: passControlller,
          ),
          const SizedBox(height: 30),
          Center(
            child: Consumer<UserManager>(builder: (_, authService, __) {
              return RaisedButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                shape: const StadiumBorder(),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: !authService.loading
                    ? () async {
                        if (userController.text.trim().isNotEmpty ||
                            passControlller.text.trim().isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          final loginOk = await authService.login(
                            userController.text.trim(),
                            passControlller.text.trim(),
                          );

                          if (loginOk) {
                            Navigator.pushReplacementNamed(
                                context, "/contacts_screen");
                          } else {
                            //   mostrar alerta
                            showAlert(
                              context,
                              "Login incorreto",
                              'Verifique seus credencias',
                            );
                          }
                        } else {
                          showAlert(
                            context,
                            "Erro",
                            'Preencha os campos',
                          );
                        }
                      }
                    : null,
               
                child: const Text("Entrar"),
              );
            }),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
