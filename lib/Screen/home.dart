import 'package:flutter/material.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Model/coinModel.dart';
import 'package:wallet_app_ef1/Model/navigationModel.dart';
import 'package:wallet_app_ef1/Screen/swap.dart';
import 'package:wallet_app_ef1/Screen/wallet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  static const route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            Text(
              "Hi, 0xabcxxx...001",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("What would you like to work with ?"),
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/wallet_button.png'),
                              fit: BoxFit.cover)),
                      child: InkWell(
                        onTap: () {
                          NavigationProvider.of(context).setAppBar(true);
                          NavigationProvider.of(context).setTitle("");
                          NavigationProvider.of(context)
                              .setChildTitle("Wallet");
                          Navigator.of(
                            context,
                            rootNavigator: false,
                          ).pushNamed(WalletPage.route);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 178,
                          width: 154,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 78,
                              ),
                              Text(
                                "Wallet",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                "You can start use",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Ink(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/swap_button.png'),
                              fit: BoxFit.cover)),
                      child: InkWell(
                        onTap: () {
                          NavigationProvider.of(context).setAppBar(true);
                          NavigationProvider.of(context).setTitle("");
                          NavigationProvider.of(context).setChildTitle("Swap");
                          Navigator.of(
                            context,
                            rootNavigator: false,
                          ).pushNamed(SwapPage.route);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 178,
                          width: 154,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 78,
                              ),
                              Text(
                                "Swap",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                "You can start use",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: coinModel[index].icon,
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  coinModel[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(coinModel[index].price.toString()),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(coinModel[index].price.toString()),
                                Text(coinModel[index].lastPrice.toString()),
                              ],
                            ),
                            LoginButton(
                              minWidth: 52,
                              height: 20,
                              text: "View",
                              textColor: Colors.white,
                              borderRadius: 10,
                              borderColor: colorGreen,
                              color: colorGreen,
                              fontSize: 10,
                            )
                          ],
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: coinModel.length),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: Center(
                child: Ink(
                  decoration: BoxDecoration(
                    color: colorBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          Text(
                            'Add Wallet',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
