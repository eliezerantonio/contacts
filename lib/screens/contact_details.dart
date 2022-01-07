import 'package:animate_do/animate_do.dart';
import 'package:contacts/models/contact_manager.dart';
import 'package:contacts/models/contacts.dart';
import 'package:contacts/widgets/custom_textformfield.dart';
import 'package:contacts/widgets/show_alert.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails({Key? key}) : super(key: key);
  GlobalKey<FormState> fomrKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contact = ModalRoute.of(context)!.settings.arguments as Contact;

    final contacts = context.watch<Contact>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: fomrKey,
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInRightBig(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    FadeInUp(
                      from: 7.0,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Text(
                          contact.name![0],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(contact.name!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4),
                    Text(contact.email!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15)),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FadeInUp(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (await canLaunch('tel:${contact.phone}')) {
                                    launch('tel:${contact.phone}');
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.call,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Icon(
                                  Icons.message,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final Uri _emailLaunchUri = Uri(
                                      scheme: 'mailto',
                                      path: '${contact.email}',
                                      queryParameters: {
                                        'subject':
                                            'Example Subject & Symbols are allowed!'
                                      });
                                  launch(_emailLaunchUri.toString());
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Icon(
                                    Icons.email,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          initialValue: contact.name!,
                          hintText: "Nome",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          initialValue: contact.email!,
                          hintText: "E-mail",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          initialValue: contact.phone!,
                          hintText: "Telefone",
                        ),
                        const SizedBox(height: 30),
                        RaisedButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 15),
                          shape: const StadiumBorder(),
                          color: Colors.black,
                          textColor: Colors.white,
                          onPressed: !contacts.loading
                              ? () async {
                                  if (contact.name!.isNotEmpty &&
                                      contact.phone!.isNotEmpty &&
                                      contact.email!.isNotEmpty) {
                                    if (fomrKey.currentState!.validate()) {
                                      fomrKey.currentState!.save();
                                      final ok = await contacts.update(
                                        contact.name!,
                                        contact.phone!,
                                        contact.email!,
                                        contact.id!,
                                      );
                                      if (ok) {
                                        showAlert(
                                          context,
                                          "Sucesso",
                                          'Dados Atualizados ',
                                        );
                                      } else {
                                        showAlert(
                                          context,
                                          "Cadastro incorreto",
                                          'Verifique os dados',
                                        );
                                      }
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
                          child: const Text("Editar"),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
