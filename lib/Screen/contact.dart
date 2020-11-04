import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Model/contactModel.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);

  void search(String search) {
    searchList = [];
    if (search.isNotEmpty) {
      for (int i = 0; i < contactList.length; i++) {
        if (contactList[i].alias.toLowerCase().contains(search) ||
            contactList[i].address.toLowerCase().contains(search)) {
          setState(() {
            searchList.add(contactList[i]);
          });
        }
      }
    } else {
      setState(() {
        searchList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    contactList.sort((a, b) {
      return a.alias
          .toString()
          .toLowerCase()
          .compareTo(b.alias.toString().toLowerCase());
    });
    return Scaffold(
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                cursorColor: colorBlue,
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 14.0,
                  letterSpacing: 1.2,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () {},
                  ),
                  hintText: "Search",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorBlack),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: colorBlack),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: colorBlack),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                    letterSpacing: 1.2,
                  ),
                  isDense: true,
                ),
                controller: _searchController,
                onFieldSubmitted: (value) {
                  search(value);
                },
                onChanged: (value) {
                  _debouncer.run(() {
                    search(value);
                  });
                },
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Flexible(
              child: GroupedListView<ContactModel, String>(
                elements: searchList.isEmpty ? contactList : searchList,
                groupBy: (element) => element.alias.substring(0, 1),
                groupSeparatorBuilder: (String groupByValue) => Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(groupByValue),
                ),
                itemBuilder: (context, ContactModel element) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: element.avatar,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.alias,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            element.address,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                useStickyGroupSeparators: true,
                floatingHeader: false,
                order: GroupedListOrder.ASC,
                separator: Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
