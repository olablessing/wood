import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/theme.dart';

void main() {
  runApp(WoodCafe());
}

class WoodCafe extends StatefulWidget {
  final GlobalState globalState = GlobalState();

  WoodCafe({Key? key}) : super(key: key);

  @override
  _OporAppState createState() => _OporAppState();
}

class _OporAppState extends State<WoodCafe> {
  late Future<GlobalState> initFuture = widget.globalState.setInitData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Global app state
        ChangeNotifierProvider<GlobalState>.value(
          value: widget.globalState,
        ),
        ChangeNotifierProvider<CartState>.value(
          value: widget.globalState.cartState,
        ),
      ],
      child: FutureBuilder<GlobalState>(
        future: initFuture,
        builder: (BuildContext context, AsyncSnapshot<GlobalState> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return RootWidget(widget.globalState);
            default:
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Container(
                    color: Colors.blue,
                    width: 30,
                    height: 30,
                  ));
          }
        },
      ),
    );
  }
}

class RootWidget extends StatelessWidget {
  final GlobalState globalState;
  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  const RootWidget(this.globalState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      onGenerateRoute: onGenerateRoute,
      title: 'Wood Cafe',
      theme: CustomTheme().lightTheme,
      initialRoute: !globalState.firstTime
          ? globalState.isLoggedIn
              ? PageRoutes.home
              : PageRoutes.signIn
          : PageRoutes.onboarding,
    );
  }
}
