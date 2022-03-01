import 'package:flutter/material.dart';
import 'package:wood_cafe/theme.dart';

class Loaders {
  static BuildContext? currentContext;

  static Future<bool?> showModalLoading(context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      // useRootNavigator: true,
      builder: (BuildContext context) {
        currentContext = context;
        return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            child: Center(
              child: Container(
                height: 100,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const CircularProgressIndicator.adaptive(
                      strokeWidth: 2.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Loading",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.white))
                  ],
                ),
              ),
            ));
      },
    );
  }

  static Future<bool?> showSheetLoading(context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      // useRootNavigator: true,
      builder: (BuildContext context) {
        currentContext = context;
        return const Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            child: BottomLoader());
      },
    );
  }

  static void showSnackLoading(BuildContext context, {String? message}) {
    ThemeData theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: primaryColor,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: Duration(seconds: 6), // double.infinity probaly not cool
      content: Row(
        children: <Widget>[
          SizedBox(
            height: 20,
            width: 20,
            child: Theme(
                data: theme.copyWith(accentColor: theme.accentColor),
                child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.white))),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text("${message ?? 'Loading'}"),
          ),
        ],
      ),
    ));
  }
}

class BottomLoader extends StatefulWidget {
  final String message;
  const BottomLoader({Key? key, this.message: "Loading"}) : super(key: key);

  @override
  _BottomLoaderState createState() => _BottomLoaderState();
}

class _BottomLoaderState extends State<BottomLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: [
          Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 2.5,
              )),
          Expanded(
              child: Text(
            widget.message,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
