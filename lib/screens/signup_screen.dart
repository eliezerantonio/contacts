import 'package:animate_do/animate_do.dart';
import 'package:contacts/models/user_manager.dart';
import 'package:contacts/widgets/custom_textformfield.dart';
import 'package:contacts/widgets/show_alert.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final userController = TextEditingController();
  final passControlller = TextEditingController();
  final nameControlller = TextEditingController();
  final confirmPassControlller = TextEditingController();

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
        Text("Cadastro",
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
          const Text("Email"),
          const SizedBox(height: 15),
          CustomTextFormField(
            hintText: 'yuri@gmail.com',
            controller: userController,
          ),
          const SizedBox(height: 20),
          const Text("Senha"),
          const SizedBox(height: 15),
          CustomTextFormField(
            hintText: '******',
            isPassword: true,
            controller: passControlller,
          ),
          const SizedBox(height: 20),
          const Text("Confirmar Senha"),
          const SizedBox(height: 15),
          CustomTextFormField(
            hintText: '******',
            isPassword: true,
            controller: confirmPassControlller,
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
                        if (confirmPassControlller.text.trim().isNotEmpty !=
                            passControlller.text.trim().isNotEmpty) {
                          showAlert(
                            context,
                            "Senhas nao conferem",
                            'Verifique suas credencias',
                          );
                          return;
                        }

                        if (userController.text.trim().isNotEmpty ||
                            passControlller.text.trim().isNotEmpty ||
                            nameControlller.text.trim().isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          final loginOk = await authService.signUp(
                            userController.text.trim(),
                            passControlller.text.trim(),
                            nameControlller.text.trim(),
                          );

                          if (loginOk) {
                            Navigator.pushReplacementNamed(
                                context, "/contacts_screen");
                          } else {
                            //   mostrar alerta
                            showAlert(
                              context,
                              "LogiCadastro incorreto",
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
                child: const Text("Cadastrar"),
              );
            }),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
