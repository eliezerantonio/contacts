import 'package:animate_do/animate_do.dart';
import 'package:contacts/models/contact_manager.dart';
import 'package:contacts/models/contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_textformfield.dart';
import 'show_alert.dart';

Future modalSave(BuildContext context) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: Consumer<Contact>(builder: (_, contactService, __) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FadeIn(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(
                          Icons.people,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Nome",
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "E-mail",
                        type: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        hintText: "Telefone",
                        type: TextInputType.phone,
                        controller: phoneController,
                      ),
                      const SizedBox(height: 30),
                      RaisedButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15),
                        shape: const StadiumBorder(),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: !contactService.loading
                            ? () async {
                                if (emailController.text.isNotEmpty &&
                                    phoneController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty) {
                                  final ok = await contactService.save(
                                      nameController.text,
                                      emailController.text,
                                      phoneController.text);
                                  if (ok) {
                                    Navigator.pop(context);
                                  } else {
                                    showAlert(
                                      context,
                                      "Cadastro incorreto",
                                      'Verifique os dados',
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
                        child: const Text("Salvar"),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      });
}
