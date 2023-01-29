import 'package:contacts_app/src/helpers/common_actions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact App"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: Center(child: CupertinoActivityIndicator()),
        child: Visibility(
          visible: contacts.length > 0,
          replacement: Text("no contacts found on your device"),
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Contact contactItem = contacts[index];
              String mobNos =
                  (contactItem.phones ?? []).map((e) => e.value).join(",");
              return ListTile(
                title: Text("${contactItem.displayName}"),
                subtitle: Text(mobNos),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          String mobNo = contactItem.phones ?? [].first.value;
                          CommonActions.makeCall(mobNo);
                        },
                        icon: Icon(Icons.call)),
                    IconButton(
                        onPressed: () {
                          String mobNo = contactItem.phones ?? [].first.value;
                          CommonActions.sendSms(mobNo, 'content');
                        },
                        icon: Icon(Icons.sms)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void initState() {
    getContacts();

    super.initState();
  }

  Future<void> getContacts() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      List<Contact> contactsTemp = await ContactsService.getContacts();
      setState(() {
        contacts = contactsTemp;
        isLoading = false;
      });
    } else {
      setState(() {
        contacts = [];
        isLoading = true;
      });
    }
  }
}
