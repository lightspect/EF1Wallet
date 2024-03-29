import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wallet_app_ef1/Common/color_utils.dart';
import 'package:wallet_app_ef1/Common/reusable_widget.dart';
import 'package:wallet_app_ef1/Screen/contact.dart';
import 'package:wallet_app_ef1/Screen/history.dart';
import 'package:wallet_app_ef1/Screen/home.dart';
import 'package:wallet_app_ef1/Screen/navMenu.dart';
import 'package:wallet_app_ef1/Screen/profile.dart';
import 'package:wallet_app_ef1/Screen/swap.dart';
import 'package:wallet_app_ef1/Screen/wallet.dart';

import '../localizations.dart';
import 'screenModel.dart';

const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;
const FOURTH_SCREEN = 3;

class NavigationProvider extends ChangeNotifier {
  /// Shortcut method for getting [NavigationProvider].
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = FIRST_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  bool _appBarVisibility = false;

  bool get appBarVisible => _appBarVisibility;

  bool _sendPage = false;

  bool get sendPage => _sendPage;

  String _title = AppLocalizations.instance.translate('homeTitle');

  String get title => _title;

  String _childTitle = "";

  String get childTitle => _childTitle;

  Color _selectedColor = colorBlue;

  Color get selectedColor => _selectedColor;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print('Generating route: ${settings.name}');
    switch (settings.name) {
      case WalletPage.route:
        return MaterialPageRoute(builder: (_) => WalletPage());
      case SwapPage.route:
        return MaterialPageRoute(builder: (_) => SwapPage());
      default:
        return MaterialPageRoute(builder: (_) => NavMenu());
    }
  }

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: AppLocalizations.instance.translate('homeTitle'),
      child: HomePage(),
      initialRoute: HomePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          case WalletPage.route:
            return MaterialPageRoute(builder: (_) => WalletPage());
          case SwapPage.route:
            return MaterialPageRoute(builder: (_) => SwapPage());
          default:
            return MaterialPageRoute(builder: (_) => HomePage());
        }
      },
    ),
    SECOND_SCREEN: Screen(
      title: AppLocalizations.instance.translate('contactTitle'),
      child: ContactPage(),
      initialRoute: ContactPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => ContactPage());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: AppLocalizations.instance.translate('historyTitle'),
      child: HistoryPage(),
      initialRoute: HistoryPage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => HistoryPage());
        }
      },
      scrollController: ScrollController(),
    ),
    FOURTH_SCREEN: Screen(
      title: AppLocalizations.instance.translate('profileTitle'),
      child: ProfilePage(),
      initialRoute: ProfilePage.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        print('Generating route: ${settings.name}');
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => ProfilePage());
        }
      },
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  /// Set currently visible tab.
  void setTab(int tab) {
    final currentNavigatorState = currentScreen.navigatorState.currentState;
    if (tab == currentTabIndex) {
      /// Check if user not in Send Page
      if (!_sendPage) {
        /// Check if user in a child Page then when press will go to Parent Page
        if (currentNavigatorState.canPop()) {
          currentNavigatorState.pop();
          _appBarVisibility = false;
        }
        _scrollToStart();
      } else {
        _appBarVisibility = false;
        _currentScreenIndex = tab;
        _sendPage = false;
        _selectedColor = colorBlue;
        notifyListeners();
      }
    } else {
      _appBarVisibility = false;
      _currentScreenIndex = tab;
      _sendPage = false;
      _selectedColor = colorBlue;
      notifyListeners();
    }
  }

  /// Set title
  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  /// Set child title
  void setChildTitle(String childTitle) {
    _childTitle = childTitle;
    notifyListeners();
  }

  /// Set selected color when moving to and from Send Page
  void setSelectedColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }

  /// Set AppBar Visibility.
  void setAppBar(bool state) {
    _appBarVisibility = state;
    notifyListeners();
  }

  /// Set SendPage state
  void setSendPage(bool state) {
    _title = AppLocalizations.instance.translate('sendTitle');
    _sendPage = state;
    notifyListeners();
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen.scrollController != null) {
      if (currentScreen.scrollController.hasClients) {
        currentScreen.scrollController.animateTo(
          0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (_sendPage) {
      setTab(FIRST_SCREEN);
      setSendPage(false);
      setTitle(AppLocalizations.instance.translate('homeTitle'));
      setChildTitle("");
      notifyListeners();
      print("From Send Page");
      print("Title: " + title + " Child: " + childTitle);
      return false;
    } else if (currentNavigatorState.canPop()) {
      setAppBar(false);
      setTitle(currentScreen.title);
      notifyListeners();
      setChildTitle("");
      currentNavigatorState.pop();
      print("From Child Page");
      print("Title: " + title + " Child: " + childTitle);
      return false;
    } else {
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        if (childTitle.isNotEmpty) {
          setTitle("");
        } else {
          setTitle(AppLocalizations.instance.translate('homeTitle'));
        }
        print("From Other Page");
        print("Title: " + title + " Child: " + childTitle);
        notifyListeners();
        return false;
      } else {
        return await showDialog(
          context: context,
          builder: (context) => ExitAlertDialog(),
        );
      }
    }
  }
}
