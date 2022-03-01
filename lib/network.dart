// base file for network request
// Include show modal of two types (modal and snack)
// making a post request ( also surports file uploading )
// supports online and offline
// print(await http.read('http://example.com/foobar.txt'));

import 'package:flutter/material.dart';

// dio implementation
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:provider/provider.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/routes.dart';

import 'package:wood_cafe/widgets/loaders.dart';
import 'package:wood_cafe/tools.dart' as tools;

// ignore: constant_identifier_names
const String BACKEND_URL = "http://foods.loftywebtech.com:3000/";

enum NetworkStatus { success, failure, error, redirect }
enum LoaderType {
  popup,
  snack,
  sheet,
}

class NetworkResponse {
  final body;
  final Headers? headers;
  final NetworkStatus? status;
  final int? statusCode;
  NetworkResponse({this.headers, this.body, this.status, this.statusCode});
}

typedef NetworkCallback = Future<bool> Function(
    NetworkResponse response, dynamic result);

typedef NetworkSuccessCallback = void Function(
    NetworkResponse response, dynamic result);

class HttpRequest {
  /// url: can be either full path or not
  /// if path ins't full, if will be concatinated to the [BASE_URL]
  final String url;
  final String baseUrl;
  final String loadingMessage;

  final bool silent;

  /// method used in request
  String method;

  final dynamic body;

  // files to be uploaded on a post /put request
  final List? files;

  /// options are [modal] and [snack]
  final LoaderType? loader;

  /// use online cache
  final bool useCache;

  /// always try to use cache if available
  final bool forceRefresh;

  /// allow saving network result offline
  // final bool offlineCache;

  final int cacheTimeout; // cache timeout in minutes *(defaults to 20 minutes)

  /// internal token used for request
  String? _accessToken;

  // String get _cacheKey => '$_fullUrl.$method';

  /// callback Methods
  final NetworkSuccessCallback? onSuccess;
  final NetworkCallback? onFailure;
  final Function? onError;
  final Function? onRedirect;
  final int timeout;

  final BuildContext? context;

  Map<String, String>? headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  final bool ignoreToken;

  HttpRequest(
    this.url, {
    this.method = 'GET',
    this.baseUrl = BACKEND_URL,
    this.body,
    this.loader,
    this.onSuccess,
    this.onRedirect,
    this.loadingMessage = "Loading",
    this.onFailure,
    this.onError,
    this.timeout = 20000,
    this.context,
    this.files,
    this.useCache = false,
    this.forceRefresh = false,
    this.silent = false,
    this.ignoreToken = false,
    this.cacheTimeout = 20,
    this.headers,
  });

  Future<NetworkResponse> send() async {
    // get token
    _accessToken = await tools.getFromStore('accessToken');
    if (_accessToken != null && !ignoreToken) {
      headers = {...?headers};
      headers!['Authorization'] = 'Bearer $_accessToken';
    }
    print("headers: $headers");
    // headers!['Authorization'] = 'Bearer  $_accessToken';
    print(_accessToken);

    var dio = Dio();

    // Firebase Perfrmance Interceptor
    // var performanceInterceptor = DioFirebasePerformanceInterceptor();
    // dio.interceptors.add(performanceInterceptor);

    // try {
    //   if (useCache)
    //     dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    // } catch (e, stack) {
    //   print("local network cache not supported $stack $e");
    // }

    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    dio.options.headers = headers;

    // auto set post method
    if (method == 'GET' && body != null) {
      method = 'POST';
    }

    // file upload
    if (files != null) {
      files?.forEach((file) async {
        body[file] = await MultipartFile.fromFile(
          body[file],
        );
      });
    }
    var data = body;
    // FormData data = FormData.fromMap(body);

    // display loading modal if set
    try {
      switch (loader) {
        case (LoaderType.snack):
          Loaders.showSnackLoading(context!, message: loadingMessage);
          break;
        case (LoaderType.popup):
          Loaders.showModalLoading(context).then((reason) {
            if (reason == null) {
              dio.close();
            } //'close connection';
          });
          break;
        case (LoaderType.sheet):
          Loaders.showModalLoading(context).then((reason) {
            if (reason == null) {
              dio.close();
            } //'close connection';
          });
          break;
        default:
      }
    } catch (e, stack) {
      print(stack);
    }

    Response? response;
    try {
      switch (method) {
        case 'GET':
          response = await dio.get(url,
              options: buildCacheOptions(Duration(minutes: cacheTimeout),
                  forceRefresh: forceRefresh));
          break;
        case 'POST':
          response = await dio.post(url, data: data);
          break;
        case 'PATCH':
          response = await dio.patch(url, data: data);
          break;
        case 'PUT':
          response = await dio.put(url, data: data);
          break;
        case 'DELETE':
          response = await dio.delete(url);
          break;
      }
    } on DioError catch (e, stack) {
      print(stack);
      response = e.response;
      if (response == null) {
        _onError(e);
        print(response?.headers);
        return NetworkResponse(
            headers: response?.headers,
            status: NetworkStatus.error,
            body: null);
      }
    } finally {
      // remove loading widget if available
      // await Future.delayed(Duration(seconds: 1));
      try {
        switch (loader) {
          case (LoaderType.snack):
            ScaffoldMessenger.of(context!).removeCurrentSnackBar();
            break;
          default:
            Navigator.of(context!).pop(true);
        }
      } catch (e) {
        print(e);
      }
    }

    // if (response == null) return null;
    // lastly parse the response
    return parseResponse(response);
  }

  /// Parse the response to determine if it
  /// was a success, failure, error or redirect
  /// the optional aurgment [ responseBody ] is avaliable if
  /// the response obj doen't have a body
  NetworkResponse parseResponse(Response? response) {
    var responseBody = response!.data;
    int statusCode = response.statusCode!;
    if ('$statusCode'.startsWith('2') &&
        (responseBody != null && responseBody['statusCode'] == 1)) {
      NetworkResponse _response = NetworkResponse(
          headers: response.headers,
          status: NetworkStatus.success,
          body: responseBody,
          statusCode: statusCode);
      _onSuccess(_response, responseBody);

      return _response;
    } else if (response.isRedirect!) {
      NetworkResponse _response = NetworkResponse(
          headers: response.headers,
          status: NetworkStatus.redirect,
          body: null,
          statusCode: statusCode);
      _onRedirect(_response);
      return _response;
    } else {
      NetworkResponse _response = NetworkResponse(
          headers: response.headers,
          status: NetworkStatus.failure,
          body: responseBody,
          statusCode: statusCode);
      _onFailure(_response, responseBody);
      return _response;
    }
  }

  void _onSuccess(NetworkResponse response, result) {
    print('Network success from $url, $result');
    if (onSuccess != null) {
      onSuccess!(response, result);
    }
  }

  void showUserError(message) {
    if (context == null) return;
    showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
              title: Text('Error'),
              content: ListView(
                children: <Widget>[Text('$message')],
              ));
        });
  }

  void _onFailure(NetworkResponse response, responseBody) async {
    print("$url Network failure ${response.statusCode} $responseBody");
    bool? _terminate;
    if (onFailure != null) {
      _terminate = await onFailure!(response, responseBody);
    }
    if (_terminate != null && _terminate) return null;

    if (response.statusCode == 401 ||
        (responseBody != null && responseBody['statusCode'] == 2)) {
      if (context != null) {
        var globalState = Provider.of<GlobalState>(context!, listen: false);
        globalState.logout();
        Navigator.of(context!).pushReplacementNamed(PageRoutes.signIn,
            arguments: ModalRoute.of(context!)!.settings.name);
        tools.showToast('Sorry you have to login');
        return;
      }
    }

    String msg = 'connection failed!';
    try {
      if (responseBody.keys.contains('message')) {
        msg = responseBody['message'];
      }
    } catch (e) {
      try {
        msg = (responseBody as String).substring(0, 50);
      } catch (e) {}
      print("connection error $e");
    } finally {
      if (!silent) {
        tools.showToast(msg);
      }
    }
  }

  void _onRedirect(NetworkResponse response) {
    if (!silent) {
      tools.showToast('Connection redirect, try again');
    }
    print('Network Redirect $response');
    if (onRedirect != null) {
      onRedirect!(response);
    }
  }

  void _onError(DioError error) {
    print('wood_cafe network error ${error.message}');
    if (onError != null) {
      try {
        onError!(error);
      } catch (error) {}
    }
    if (!silent) {
      tools.showToast('Connection error, try again');
    }
  }
}
