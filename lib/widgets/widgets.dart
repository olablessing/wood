/// Authors (avour, ...)

export 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wood_cafe/network.dart';

import 'package:flutter/material.dart';
import 'package:wood_cafe/theme.dart';

class ErrorDisplay extends StatelessWidget {
  final VoidCallback? onRefresh;
  final String title;
  final IconData? icon;
  final bool dense;
  final String? actionText;

  ErrorDisplay({
    this.onRefresh,
    this.dense = false,
    this.title = 'Oops!, a network error occured.',
    this.actionText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (dense) {
      return ListTile(
        leading: Icon(icon ?? Icons.error),
        title: Text(title),
        subtitle: Text(title),
        trailing: (onRefresh != null)
            ? IconButton(
                icon: Icon(MdiIcons.refresh),
                onPressed: onRefresh,
              )
            : null,
      );
    }
    return Center(
        child: Column(children: [
      SizedBox(height: 10),
      Icon(icon ?? MdiIcons.emoticonSad, color: Colors.orangeAccent, size: 80),
      Text(title),
      SizedBox(height: 10),
      (onRefresh != null)
          ? TextButton(
              style: outlinedButtonStyle().copyWith(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15))),
              child: Text(actionText ?? 'Refresh'),
              onPressed: onRefresh,
            )
          : Container(),
    ]));
  }
}

// class PasswordField extends StatefulWidget {
//   const PasswordField(
//       {required this.fieldKey,
//       required this.hintText,
//       required this.labelText,
//       required this.helperText,
//       required this.style,
//       required this.labelStyle,
//       required this.onSaved,
//       required this.validator,
//       required this.onFieldSubmitted,
//       required this.borderDecoration,
//       required this.errorborderDecoration,
//       required this.focusedborderDecoration,
//       required this.onChanged,
//       required this.errorText,
//       required this.prefixIcon,
//       required this.controller,
//       required this.focusNode});

//   final Key fieldKey;
//   final String hintText;
//   final String labelText;
//   final String helperText;
//   final String errorText;
//   final TextStyle style;
//   final TextStyle labelStyle;
//   final FocusNode focusNode;
//   final TextEditingController controller;
//   final FormFieldSetter<String> onSaved;
//   final FormFieldValidator<String> validator;
//   final ValueChanged<String> onFieldSubmitted;
//   final InputBorder borderDecoration;
//   final InputBorder errorborderDecoration;
//   final InputBorder focusedborderDecoration;
//   final ValueChanged<String> onChanged;
//   final Icon prefixIcon;

//   @override
//   _PasswordFieldState createState() => new _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return new TextFormField(
//       key: widget.fieldKey,
//       // autovalidate: true,
//       enabled: true,
//       focusNode: widget.focusNode,
//       obscureText: _obscureText,
//       onSaved: widget.onSaved,
//       validator: widget.validator,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       onChanged: widget.onChanged,
//       controller: widget.controller,
//       style: widget.style,
//       decoration: new InputDecoration(
//         border: widget.borderDecoration,
//         errorBorder: widget.errorborderDecoration,
//         focusedErrorBorder: widget.errorborderDecoration,
//         focusedBorder: widget.focusedborderDecoration,
//         hintText: widget.hintText,
//         labelText: widget.labelText,
//         labelStyle: widget.labelStyle,
//         helperText: widget.helperText,
//         errorText: widget.errorText,
//         suffixIcon: new GestureDetector(
//           onTap: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           child:
//               new Icon(_obscureText ? MdiIcons.eye : MdiIcons.eyeOff, size: 16),
//         ),
//       ),
//     );
//   }
// }

typedef RequestBuilder = Widget Function(
    BuildContext context, NetworkResponse data);
typedef RequestFuture = Future<NetworkResponse> Function();

class RequestWidget extends StatefulWidget {
  final Future<NetworkResponse> request;
  final RequestFuture getRequest;
  final RequestBuilder onSuccess;
  final RequestBuilder? onError;
  final RequestBuilder? onFailure;
  final WidgetBuilder? onLoading;
  final bool allowDragReloading;
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final bool usingCache;

  RequestWidget(
      {required this.request,
      required this.onSuccess,
      this.onFailure,
      this.onError,
      required this.allowDragReloading,
      required this.getRequest,
      this.onLoading,
      this.usingCache = false,
      this.refreshKey})
      : super();

  @override
  RequestWidgetState createState() => RequestWidgetState();
}

class RequestWidgetState extends State<RequestWidget> {
  late Future<NetworkResponse> _future;
  bool _isReloading = false;

  @override
  void initState() {
    super.initState();
    _future = widget.request;
    if (widget.usingCache) {
      var _request = widget.getRequest();
      _request.then((value) {
        if (value.status == NetworkStatus.success)
          setState(() {
            _future = _request;
          });
      });
    }
  }

  Future<NetworkResponse> _getFuture() async {
    NetworkResponse response = await widget.getRequest();
    _isReloading = false;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.allowDragReloading) {
      return RefreshIndicator(
        key: widget.refreshKey,
        onRefresh: () {
          setState(() {
            this._isReloading = true;
            this._future = _getFuture();
          });
          return this._future;
        },
        child: _buildFutureWidget(),
      );
    }
    return _buildFutureWidget();
  }

  Widget _buildFutureWidget() {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<NetworkResponse> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _buildProgressIndicator();
          // return !_isReloading
          // ? Center(child: _buildProgressIndicator())
          // : Container();

          default:
            NetworkResponse? response = snapshot.data;
            if (snapshot.hasData) {
              if (response!.status == NetworkStatus.success) {
                return widget.onSuccess(context, response);
              } else if (response.status == NetworkStatus.failure) {
                return _buildFailure(response);
              } else {
                return _buildError(response);
              }
            } else {
              return _buildError(response);
            }
        }
      },
    );
  }

  Widget _buildProgressIndicator() {
    if (widget.onLoading == null)
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
      );
    return widget.onLoading!(context);
  }

  Widget _buildError(response) {
    if (widget.onError == null)
      return _defaultErrorWidget();
    else
      return widget.onError!(context, response);
  }

  Widget _buildFailure(response) {
    if (widget.onFailure == null)
      return _defaultErrorWidget();
    else
      return widget.onFailure!(context, response);
  }

  Widget _defaultErrorWidget() {
    return ErrorDisplay(
      onRefresh: () {
        setState(() {
          this._future = _getFuture();
        });
      },
    );
  }
}

class EmptyPageWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? action;
  const EmptyPageWidget(
      {Key? key,
      required this.title,
      this.subtitle,
      this.actionText,
      this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: headerTextColor)),
          SizedBox(height: 10),
          Text(
            subtitle ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: bodyTextColor.withOpacity(0.8)),
          ),
          SizedBox(height: 20),
          if (actionText != null)
            TextButton(
                onPressed: action,
                child: Text(
                  actionText!,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: primaryColor),
                ))
        ],
      ),
    );
  }
}
