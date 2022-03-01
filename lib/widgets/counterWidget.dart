import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class CounterView extends StatefulWidget {
  final int? initNumber;
  final int? currentCount;
  final bool allowZero;
  final Icon? addIcon;
  final Icon? removeIcon;
  final bool disabled;
  final Text? plusMinus;

  final Function(int)? counterCallback;
  final Function? increaseCallback;
  final Function? decreaseCallback;
  final Function? disabledCallback;

  const CounterView(
      {this.initNumber,
      this.currentCount,
      this.allowZero = false,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback,
      this.disabledCallback,
      this.addIcon,
      this.removeIcon,
      this.plusMinus,
      this.disabled: false});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _currentCount = 1;
  Function? _counterCallback;
  Function? _increaseCallback;
  Function? _decreaseCallback;
  TextEditingController countController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentCount = widget.initNumber ?? 1;
    countController.text = _currentCount.toString();
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
  }

  @override
  Widget build(BuildContext context) {
    _currentCount = widget.currentCount ?? _currentCount;
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        // border: Border.fromBorderSide(BorderSide(width: 0.8))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _createIncrementDicrementButton(
              widget.plusMinus ??
                  Text(
                    '-',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                  ),
              () => (widget.disabled)
                  ? widget.disabledCallback!()
                  : _dicrement()),
          Container(
            width: 40,
            height: 25,
            margin: EdgeInsets.symmetric(horizontal: 1),
            child: Center(
              child: TextFormField(
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enabled: !widget.disabled,
                onChanged: (String value) {
                  setState(() {
                    int val = int.tryParse(value) ?? 0;
                    _currentCount = (val > 0) ? val - 1 : 0;
                    print(_currentCount);
                  });
                },
                controller: countController,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: "GilroyMedium",
                    color: Color.fromRGBO(0, 0, 0, 0.8)),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    disabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 2)),
              ),
            ),
          ),
          _createIncrementDicrementButton(
              widget.plusMinus ??
                  Text(
                    '+',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                  ),
              () => (widget.disabled)
                  ? widget.disabledCallback!()
                  : _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      print("Current Count: $_currentCount");
      _currentCount++;
      print("Current Count Now: $_currentCount");
      _counterCallback!(_currentCount);
      countController.text = (_currentCount).toString();
      _increaseCallback!();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > (widget.allowZero ? 0 : 1)) {
        _currentCount--;
        _counterCallback!(_currentCount);
        countController.text = (_currentCount).toString();
        _decreaseCallback!();
      }
    });
  }

  Widget _createIncrementDicrementButton(Text icon, VoidCallback onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 20.0, minHeight: 20.0),
      onPressed: onPressed,
      elevation: 0,
      hoverElevation: 0,
      // fillColor: Color.fromRGBO(0, 0, 0, 0.3),
      child: icon,
      shape: CircleBorder(),
    );
  }
}
