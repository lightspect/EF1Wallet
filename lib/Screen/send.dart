import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/coinModel.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';

import '../localizations.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key key, this.title, this.callDialog, this.setRecepient})
      : super(key: key);

  final String title;
  final AsyncCallback callDialog;
  final Function(String) setRecepient;

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _feesController = TextEditingController();
  final FocusNode _recipientControllerFocus = FocusNode();
  final FocusNode _amountControllerFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final String _qrAction = "getAddress";
  List<DropdownMenuItem<CoinModel>> _dropdownMenuItems;
  List<FeesModel> _feeOptions;
  CoinModel _selectedItem;
  FeesModel _selectedFee;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(coinModel);
    _selectedItem = _dropdownMenuItems[0].value;
    _feeOptions = [
      FeesModel(AppLocalizations.instance.translate('veryFastOption'), 0.3),
      FeesModel(AppLocalizations.instance.translate('fastOption'), 0.2),
      FeesModel(AppLocalizations.instance.translate('slowOption'), 0.1)
    ];
    _selectedFee = _feeOptions[0];
    _feesController.text = _selectedFee.value.toString();
  }

  void _navigateAndReturnData() async {
    final result =
        await Navigator.pushNamed(context, '/qrscan', arguments: _qrAction);
    setState(() {
      if (result.toString() != "null") {
        _recipientController.text = result.toString();
      }
    });
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
          title: AppLocalizations.instance.translate('sendComplete'),
          bodySubtitle:
              AppLocalizations.instance.translate('sendSuccessSubtitle', {
            'amount': _amountController.text + " " + _selectedItem.name,
            'convert': r"$" + _selectedItem.price.toString(),
            'address': _recipientController.text ?? 'an external address'
          }),
          bodyAction: [
            LoginButton(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              color: colorBlue,
              borderColor: colorBlue,
              borderRadius: 4,
              text: AppLocalizations.of(context).translate('viewDetailButton'),
              onClick: () {
                Navigator.of(context).pop();
                NavigationProvider.of(parentContext).setTab(THIRD_SCREEN);
                NavigationProvider.of(parentContext).setTitle(
                    AppLocalizations.of(context).translate('historyTitle'));
              },
            ),
            LoginButton(
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
              color: colorGreen,
              borderColor: colorGreen,
              borderRadius: 4,
              text: AppLocalizations.of(context).translate('addAddressTitle'),
              onClick: () {
                Navigator.of(context).pop();
                NavigationProvider.of(parentContext).setTab(SECOND_SCREEN);
                NavigationProvider.of(parentContext).setTitle(
                    AppLocalizations.of(context).translate('contactTitle'));
                widget.callDialog();
                widget.setRecepient(_recipientController.text);
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

  String checkRecipient(String recipient) {
    if (recipient.isEmpty || recipient == null) {
      return AppLocalizations.of(context).translate('recipientCheckText');
    }
    return null;
  }

  String checkAmount(String amount) {
    if (!isNumeric(amount)) {
      return AppLocalizations.of(context).translate('amountCheckText');
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
                              Text(AppLocalizations.of(context)
                                  .translate('recipientHintText')),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 168,
                                    child: TextFormFieldWidget(
                                      padding: EdgeInsets.only(top: 20),
                                      hintText: AppLocalizations.of(context)
                                          .translate('recipientHintText'),
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.next,
                                      functionValidate: checkRecipient,
                                      controller: _recipientController,
                                      focusNode: _recipientControllerFocus,
                                      onSubmitField: () {
                                        changeFocus(
                                            context,
                                            _recipientControllerFocus,
                                            _amountControllerFocus);
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _navigateAndReturnData();
                                    },
                                    child: Icon(
                                      Icons.qr_code_scanner,
                                      size: 26.0,
                                    ),
                                  ),
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
                              Text(AppLocalizations.of(context)
                                  .translate('amountText')),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 168,
                                    child: TextFormFieldWidget(
                                      padding: EdgeInsets.only(top: 20),
                                      hintText: AppLocalizations.of(context)
                                          .translate('amountText'),
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.done,
                                      functionValidate: checkAmount,
                                      controller: _amountController,
                                      focusNode: _amountControllerFocus,
                                      onSubmitField: () {},
                                    ),
                                  ),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                        value: _selectedItem,
                                        items: _dropdownMenuItems,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedItem = value;
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
                              Text(AppLocalizations.of(context)
                                  .translate('feeText')),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 52,
              child: Ink(
                decoration: BoxDecoration(
                  color: Color(0xffF6A70E),
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
                        AppLocalizations.of(context).translate('sendTitle'),
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
