import 'package:animate_do/animate_do.dart';
import 'package:contacts/models/contact_manager.dart';
import 'package:contacts/models/contacts.dart';
import 'package:contacts/widgets/contact_tile.dart';
import 'package:contacts/widgets/custom_textformfield.dart';
import 'package:contacts/widgets/loading_screen.dart';
import 'package:contacts/widgets/modal_save.dart';
import 'package:contacts/widgets/show_alert.dart';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatefulWidget {
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contacts = context.watch<ContactManager>().contacts;

    return Scaffold(
      backgroundColor: contacts.isEmpty ? Colors.white : Colors.white,
      body: SafeArea(
          child: contacts.isEmpty
              ? const LoadingScreen()
              : SmartRefresher(
                  controller: _refreshController,
                    onRefresh: _getContacts,
                  child: buildBody(size, context, contacts))),
    );
  }

  Widget buildBody(Size size, BuildContext context, List contacts) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          expandedHeight: 180.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: _header(context),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ClipRRect(
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  index % 2 == 0
                      ? Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: contactTile(
                              contacts[index], 'assets/avatar.gif', context))
                      : contactTile(
                          contacts[index], 'assets/avatar2.gif', context),
                  const SizedBox(height: 6),
                ],
              ),
            ),
            childCount: contacts.length,
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return FadeInUp(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Contactos",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                GestureDetector(
                  onTap: () {
                    modalSave(context);
                  },
                  child: const Icon(
                    Icons.add_box_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.transparent,
                  hintText: 'Procurar',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  errorMaxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getContacts() async {
    _refreshController.refreshCompleted();
    context.read<ContactManager>().getContacts();
  }
}
