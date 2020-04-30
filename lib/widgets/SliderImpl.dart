import 'package:flutter/material.dart';

class SliderImpl extends StatefulWidget {
  @override
  _SliderImplState createState() => _SliderImplState();
}

class _SliderImplState extends State<SliderImpl> {

  double _value = 0;
  String _label = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider example"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Slider(
              value: _value,
              min: 0,
              max: 10,
              label: _label,
              divisions: 5,
              activeColor: Colors.red,
              inactiveColor: Colors.black26,
              onChanged: (double value){
                setState(() {
                  _value = value;
                  _label = value.toString();
                });
              },
            ),
            RaisedButton(
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: (){
                print("Selected value: " + _value.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
