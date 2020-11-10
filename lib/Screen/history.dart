import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';
import 'package:wallet_app_ef1/Model/transactionModel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/history';

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<HistoryPage> {
  int _selectedIndex = 5;

  List<TransactionModel> filteredTransaction = transactionList;

  void _filterTransaction(FilterModel filterModel) {
    filteredTransaction = [];
    DateTime now = DateTime.now();
    DateTime limitDate;
    switch (filterModel.type) {
      case "D":
        limitDate = new DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - filterModel.value);
        break;
      case "M":
        limitDate = new DateTime(DateTime.now().year,
            DateTime.now().month - filterModel.value, DateTime.now().day);
        break;
      case "Y":
        limitDate = new DateTime(DateTime.now().year - filterModel.value,
            DateTime.now().month, DateTime.now().day);
        break;
    }
    if (filterModel.value == 1) {
      filteredTransaction =
          transactionList.where((x) => x.dateTime.isAfter(limitDate)).toList();
    } else if (filterModel.type == "All") {
      filteredTransaction = transactionList;
    } else {
      filteredTransaction = transactionList
          .where(
              (x) => x.dateTime.isAfter(limitDate) && x.dateTime.isBefore(now))
          .toList();
    }
  }

  Widget _buildFilter() {
    return Card(
        elevation: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int i = 0; i < filterList.length; i++)
              FlatButton(
                height: 24,
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    _selectedIndex = i;
                    _filterTransaction(filterList[i]);
                  });
                },
                color: _selectedIndex != null && _selectedIndex == i
                    ? colorBlue
                    : Colors.white,
                textColor: _selectedIndex != null && _selectedIndex == i
                    ? Colors.white
                    : colorBlack,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(filterList[i].value != 0
                    ? filterList[i].value.toString() + filterList[i].type
                    : filterList[i].type),
              )
          ],
        ));
  }

  Widget _buildCard(int index) {
    Color textColor = colorBlack;
    String date = filteredTransaction[index].dateTime.day.toString() +
        "/" +
        filteredTransaction[index].dateTime.month.toString() +
        "/" +
        filteredTransaction[index].dateTime.year.toString();
    String time = transactionList[index].dateTime.hour.toString() +
        ":" +
        filteredTransaction[index].dateTime.minute.toString();
    if (filteredTransaction[index].status == "Success") {
      textColor = colorGreen;
    } else if (filteredTransaction[index].status == "Pending") {
      textColor = colorLightBlue;
    } else if (filteredTransaction[index].status == "Drop") {
      textColor = colorRed;
    }
    return Card(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: filteredTransaction[index].avatar,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(filteredTransaction[index].alias),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: textColor,
                            ),
                          ),
                          Text(
                            filteredTransaction[index].status,
                            style: TextStyle(color: textColor, fontSize: 10),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.access_time),
                ),
                Column(
                  children: [
                    Text(
                      date,
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      (filteredTransaction[index].dateTime.hour < 12
                              ? "AM "
                              : "PM ") +
                          time,
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              filteredTransaction[index].amount.toString(),
              style: TextStyle(
                  color: colorBlue, fontSize: 40, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _buildFilter(),
              Flexible(
                child: ListView.builder(
                    controller: NavigationProvider.of(context)
                        .screens[THIRD_SCREEN]
                        .scrollController,
                    itemCount: filteredTransaction.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCard(index);
                    }),
              )
            ],
          )),
    );
  }
}
