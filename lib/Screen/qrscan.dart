import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/contactModel.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  ContactModel user = new ContactModel(
      AssetImage("assets/images/profile.jpg"), "0xabcxxx...01", "Kobe");
  String _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;
  String _action = "";

  _qrCallback(String code, BuildContext context) {
    _action = ModalRoute.of(context).settings.arguments;
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
    if (_action == "getAddress") {
      Navigator.pop(context, code);
    } else {
      _settingModalBottomSheet(context);
    }
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Scan QR Code",
            style: TextStyle(color: colorBlack),
          ),
          backgroundColor: colorBG,
          iconTheme: IconThemeData(color: colorBlack),
        ),
        body: _camState
            ? Center(
                child: SizedBox(
                  height: 1000,
                  width: 500,
                  child: QRBarScannerCamera(
                    onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                    qrCodeCallback: (code) {
                      _qrCallback(code, context);
                    },
                  ),
                ),
              )
            : Container(
                color: colorBlack,
              ));
  }

  void _settingModalBottomSheet(context) {
    final _aliasController = TextEditingController();
    bool _visible = false;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext bc, StateSetter setSheetState) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: user.avatar,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _qrInfo,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    height: 16,
                                    minWidth: 40,
                                    onPressed: () {},
                                    textColor: Colors.white,
                                    color: colorRed,
                                    child: Text(
                                      "Copy",
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: LoginButton(
                            margin: EdgeInsets.zero,
                            borderRadius: 8,
                            text: "Add to Contact",
                            onClick: () {
                              setSheetState(() {
                                _visible = true;
                                print(_visible);
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: _visible,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Enter an alias"),
                              Container(
                                margin: EdgeInsets.only(top: 8, bottom: 16),
                                child: TextFormField(
                                  cursorColor: colorBlue,
                                  style: TextStyle(
                                    color: colorBlack,
                                    fontSize: 12.0,
                                    letterSpacing: 1.2,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Alias",
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
                                      fontSize: 12.0,
                                      letterSpacing: 1.2,
                                    ),
                                    isDense: true,
                                  ),
                                  controller: _aliasController,
                                  onFieldSubmitted: (value) {},
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LoginButton(
                                    margin: EdgeInsets.zero,
                                    height: 48,
                                    minWidth: 160,
                                    color: colorBG,
                                    borderColor: colorBlack,
                                    borderRadius: 4,
                                    text: "Cancel",
                                    textColor: colorBlack,
                                    onClick: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  LoginButton(
                                    margin: EdgeInsets.zero,
                                    height: 48,
                                    minWidth: 160,
                                    color: colorBlue,
                                    borderColor: colorBlue,
                                    borderRadius: 4,
                                    text: "Save",
                                    onClick: () {},
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          });
        }).whenComplete(() {
      setState(() {
        _camState = true;
        _visible = false;
      });
    });
  }
}
