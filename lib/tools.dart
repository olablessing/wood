import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';

/// Authors (avour, ...)
// Set of tools for wood_cafe

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';
import 'package:wood_cafe/network.dart';

const String APP_ICON = 'assets/images/ic_launcher.png';
const String APP_NAME = 'wood_cafe';
const String APP_VERSION = '1.0.0';

class PayStackKeys {
  static const liveKey = 'pk_live';
  static const testKey = 'pk_test';
}

bool isStoreInitialized = false;

Future<void> initializeStore() async {
  if (isStoreInitialized) {
    return;
  }

  if (!kIsWeb) {
    final dir = await path_provider.getApplicationSupportDirectory();
    final hiveFolder = join(dir.path); // , '.storage'
    Hive.init(hiveFolder);
  }
  isStoreInitialized = true;
}

/// Put an object in the store
Future<void> putInStore(String key, value, {String store = 'store'}) async {
  await initializeStore();
  var box = await Hive.openBox(store);
  return await box.put(key, value);
}

/// Function to put an object in the store
Future<dynamic> getFromStore(String key, {String store = 'store'}) async {
  await initializeStore();
  Box box = await Hive.openBox(store);
  return await box.get(key);
}

/// Function to put an object in the store
Future<void> removeFromStore(String key, {String store = 'store'}) async {
  await initializeStore();
  Box box = await Hive.openBox(store);
  return await box.delete(key);
}

Future<void> clearStore({store = 'store'}) async {
  await initializeStore();
  Box box = await Hive.openBox(store);
  await box.clear();
}

/// Basically calculate if the restaurant is opened
/// based on the closing and opening hour
bool isOpened(String closingHours, String openingHours) {
  // String prefix = '0000-01-01T';
  DateTime currentTime = DateTime.now();
  String prefix = currentTime.toString().split(' ').first + 'T';
  DateTime ch = DateTime.parse(prefix + closingHours);
  DateTime oh = DateTime.parse(prefix + openingHours);
  // print("Closing time: $ch, Opeing time: $oh, Current time: $currentTime");
  bool value =
      (currentTime.compareTo(oh) > 0) && (currentTime.compareTo(ch) < 0);
  return value;
}

class Validators {
// Regex func for validating a name
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'This is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) return 'Email is required.';
    final RegExp emailExp =
        RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)");
    if (!emailExp.hasMatch(value)) return 'Please enter a valid email';
    return null;
  }

  static String? checkFilledForm(Map<String, dynamic>? value) {
    bool filled =
        (value!.values.every((element) => element != null && element != ""));
    List<String> defaulters = [];
    if (!filled) {
      value.entries.forEach((element) {
        if (element.value == null || element.value == "") {
          defaulters.add(element.key);
        }
      });
      print("Form Error in: $defaulters");
      return "Please ensure the following fields are filled:\n$defaulters";
    }
    return null;
  }

  static String? validateUsername(String? value) {
    if (value!.isEmpty) return 'Username is required.';
    final RegExp emailExp = RegExp(r"^[\w.@+\- ]+$");
    if (!emailExp.hasMatch(value)) return 'invalid username';
    return null;
  }

  static String? isNotNull(String? value) {
    return (value == null) ? 'This field is required' : null;
  }

  static String? isNotEmpty(String? value) {
    return (value?.isEmpty ?? true) ? 'This field is required' : null;
  }

  static String? isNotEmpty2(String? value) {
    return (value?.isEmpty ?? true) ? '' : null;
  }

  static String? isInt(String value) {
    return (int.tryParse(value) == null) ? 'Invalid Input' : null;
  }

  static String? isDouble(String value) {
    return (double.tryParse(value) == null) ? 'Invalid Input' : null;
  }
}

void showToast(String msg, {Duration duration: const Duration(seconds: 2)}) {
  BotToast.showText(text: msg, duration: duration);
}

void showOverlay(String msg, {Duration duration: const Duration(seconds: 2)}) {
  BotToast.showLoading();
}

bool isUrl(String path) {
  if (path.startsWith('http') && path.contains('://'))
    return true;
  else
    return false;
}

String fixMessedUpPhoneNumber(String phoneNo, {countryCode = '+234'}) {
  phoneNo = phoneNo.replaceAll(RegExp(' '), '');
  if (phoneNo.startsWith('+')) {
    return phoneNo;
  }
  if (phoneNo.length == 11 || phoneNo.startsWith('0')) {
    phoneNo = phoneNo.substring(1);
  }
  return countryCode + phoneNo;
}

var priceFormatter = new NumberFormat("#,##0", "en_US");
String formatPrice(price) {
  return priceFormatter.format(price);
}

var currencyFormat =
    new NumberFormat.currency(symbol: "\u20A6", locale: "en_NG");
String formatPriceDetailed(price) {
  return currencyFormat.format(price);
}

String parseTime(DateTime obj) {
  return DateFormat.jm().format(obj);
}

String parseDate(DateTime? obj) {
  if (obj == null) return "";
  return DateFormat.yMMMd().format(obj);
}

String parseFormDateTime(DateTime? obj) {
  if (obj == null) return "";
  return DateFormat("yyyy-MM-dd").format(obj);
}

String parseAnalyticsDate(DateTime obj) {
  return DateFormat('MM/dd/yyyy').format(obj);
}

String parseDateRange(DateTimeRange range) {
  return "${DateFormat('MMMd').format(range.start)} - ${DateFormat('MMMd').format(range.end)}";
}

Future showResponseDialog(BuildContext context, String info,
    {type: 'success', actionText: 'OK', required VoidCallback? onComplete}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (ctx) {
        return Container(
          height: 435,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Column(
                    children: [
                      Icon(
                        (type == 'success')
                            ? Icons.check_circle
                            : Icons.cancel_rounded,
                        color: (type == 'success')
                            ? Colors.green
                            : Color(0xFFEE3333),
                        size: 120,
                      ),
                      Text((type == "success") ? "Done!" : "Error!",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontFamily: "GilroyMedium",
                                  color: Color.fromRGBO(0, 0, 0, 0.8))),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(info,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontFamily: "GilroyMedium",
                                      color: Colors.black.withAlpha(200)))),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, top: 0),
                  child: SizedBox(
                    height: 46,
                    width: double.maxFinite,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onComplete!();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          actionText,
                          style: Theme.of(context)
                              .textTheme
                              .button!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future checkout(BuildContext context, String info,
    {type: 'success',
    actionText: 'CHECKOUT(#4,875.00)',
    required VoidCallback? onComplete}) {
  return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (ctx) {
        return Container(
          height: 435,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20, top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(70)),
                          ),
                        ),
                      ),
                      Container(
                          width: 375.0,
                          height: 160.0,
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Other summary',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total(incl.VAT)'),
                                      Text('5375.00'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Promo code'),
                                      Text('-500'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Grand Total:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text('#4,875.00',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, top: 0),
                  child: SizedBox(
                    height: 46,
                    width: double.maxFinite,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onComplete!();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.green,
                        child: Text(
                          actionText,
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Future<DateTime?> selectDate(BuildContext context,
    {DateTime? selectedDate, DateTime? startDate, DateTime? endDate}) async {
  DateTime start =
      startDate ?? DateTime.now().subtract(Duration(days: 365 * 100));
  DateTime initial = selectedDate != null ? selectedDate : DateTime.now();
  DateTime end = endDate ?? DateTime.now().add(Duration(days: 365 * 100));

  print("Initial is: $initial");
  return showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: start,
    lastDate: end,
  );
}

Future<List<String>> getLgas(String state) async {
  print(state);
  List<String> results = [];
  await HttpRequest("/statelga/findOneState",
      body: {"state": state}, method: 'POST', onSuccess: (response, result) {
    results = result['data']['lgas'].cast<String>();
  }).send();
  return results;
}

Future<File> urlToFile(String imageUrl) async {
  // generate random number.
  var rng = new Random();
  // get temporary directory of device.
  Directory tempDir = await getTemporaryDirectory();
  // get temporary path from temporary directory.
  String tempPath = tempDir.path;
  // create a new file in temporary path with random file name.
  File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
  // call http.get method and pass imageUrl into it to get response.
  Response response = await Dio().get(imageUrl);

  // write bodyBytes received in response to file.
  await file.writeAsBytes(response.data);
  // now return the file which is created with random name in
  // temporary directory and image bytes from response is written to // that file.
  return file;
}
