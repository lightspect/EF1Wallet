import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/coinModel.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';

import '../localizations.dart';

class SwapPage extends StatefulWidget {
  const SwapPage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/home/swap';

  @override
  _SwapPageState createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  final _sendController = TextEditingController();
  final _receiveController = TextEditingController();
  final _feesController = TextEditingController();
  final FocusNode _sendControllerFocus = FocusNode();
  final FocusNode _receiveControllerFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<CoinModel>> _dropdownFromItems;
  List<DropdownMenuItem<CoinModel>> _dropdownToItems;
  List<FeesModel> _feeOptions;
  CoinModel _selectedFrom;
  CoinModel _selectedTo;
  FeesModel _selectedFee;

  void initState() {
    super.initState();
    _dropdownFromItems = buildDropDownMenuItems(coinModel);
    _dropdownToItems = buildDropDownMenuItems(coinModel);
    _selectedFrom = _dropdownFromItems[0].value;
    _selectedTo = _dropdownToItems[0].value;
    _feeOptions = [
      FeesModel(AppLocalizations.instance.translate('veryFastOption'), 0.3),
      FeesModel(AppLocalizations.instance.translate('fastOption'), 0.2),
      FeesModel(AppLocalizations.instance.translate('slowOption'), 0.1)
    ];
    _selectedFee = _feeOptions[0];
    _feesController.text = _selectedFee.value.toString();
  }

  List<DropdownMenuItem<CoinModel>> buildDropDownMenuItems(
      List<CoinModel> listItems) {
    List<DropdownMenuItem<CoinModel>> items = List();
    for (CoinModel listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: listItem.icon,
                width: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(listItem.name),
              )
            ],
          ),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<Widget> createFeesList() {
    List<Widget> widgets = [];
    for (FeesModel fees in _feeOptions) {
      widgets.add(Container(
        child: Row(
          children: [
            Radio(
              value: fees,
              groupValue: _selectedFee,
              onChanged: (currentFee) {
                setState(() {
                  _selectedFee = currentFee;
                  _feesController.text = _selectedFee.value.toString();
                });
              },
              activeColor: colorBlue,
            ),
            Text(fees.text)
          ],
        ),
      ));
    }
    return widgets;
  }

  Future<void> _showMyDialog(BuildContext parentContext) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Swap Complete",
          bodySubtitle: "You have sent " +
              _sendController.text +
              " " +
              _selectedFrom.name +
              r" ($" +
              _selectedFrom.price.toString() +
              ") to " +
              _receiveController.text +
              " " +
              _selectedTo.name,
          bodyAction: [
            LoginButton(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              color: colorBlue,
              borderColor: colorBlue,
              borderRadius: 4,
              text: "View Details",
              onClick: () {
                Navigator.of(context).pop();
                NavigationProvider.of(parentContext).setTab(THIRD_SCREEN);
                NavigationProvider.of(parentContext).setTitle("History");
              },
            ),
          ],
        );
      },
    );
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  String checkAmount(String amount) {
    if (!isNumeric(amount)) {
      return "Please enter number";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('totalText'),
                      style: TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        r"$" + "18,659.55",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "2.345678 EF1",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          "+0.15 USD/ EF1",
                          style: TextStyle(color: colorGreen, fontSize: 12),
                        ),
                        Icon(
                          Icons.arrow_drop_up,
                          color: colorGreen,
                        ),
                        Text(
                          "+1.23%",
                          style: TextStyle(color: colorGreen, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                Image(image: AssetImage("assets/images/send_refresh.png"))
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('fromText'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 168,
                                  child: TextFormFieldWidget(
                                    padding: EdgeInsets.only(top: 20),
                                    hintText: _selectedFrom.name,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.done,
                                    functionValidate: checkAmount,
                                    controller: _sendController,
                                    focusNode: _sendControllerFocus,
                                    onSubmitField: () {
                                      changeFocus(context, _sendControllerFocus,
                                          _receiveControllerFocus);
                                    },
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: _selectedFrom,
                                      items: _dropdownFromItems,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedFrom = value;
                                        });
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('toText'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 168,
                                  child: TextFormFieldWidget(
                                    padding: EdgeInsets.only(top: 20),
                                    hintText: _selectedTo.name,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.done,
                                    controller: _receiveController,
                                    focusNode: _receiveControllerFocus,
                                    onSubmitField: () {},
                                  ),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: _selectedTo,
                                      items: _dropdownToItems,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedTo = value;
                                        });
                                      }),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12),
                        width: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('feeText'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: createFeesList(),
                            )
                          ],
                        ),
                      ),
                      TextFormFieldWidget(
                        hintText: "",
                        enable: false,
                        textInputType: TextInputType.text,
                        actionKeyboard: TextInputAction.done,
                        controller: _feesController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              height: 52,
              child: Ink(
                decoration: BoxDecoration(
                  color: colorBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    var validate = _formKey.currentState.validate();
                    if (!validate) {
                    } else {
                      _formKey.currentState.save();
                      FocusScope.of(context).unfocus();
                      _showMyDialog(context);
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Swap',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
