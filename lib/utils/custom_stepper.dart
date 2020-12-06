import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

  CustomStepper(
      {this.iconSize,
      this.lowerLimit,
      this.onChanged,
      this.stepValue,
      this.upperLimit,
      this.value});
  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 10)
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.lowerLimit
                      ? widget.lowerLimit
                      : widget.value -= widget.stepValue;

                  this.widget.onChanged(widget.value);
                });
              }),
          Container(
            width: widget.iconSize,
            child: Text(
              '${widget.value}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: widget.iconSize * 0.8),
            ),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value += widget.stepValue;
                  this.widget.onChanged(widget.value);
                });
              })
        ],
      ),
    );
  }
}
