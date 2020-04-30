import 'package:flutter/material.dart';

class CheckBoxImpl extends StatefulWidget {
  @override
  _CheckBoxImplState createState() => _CheckBoxImplState();
}

class _CheckBoxImplState extends State<CheckBoxImpl> {

  bool _isJaponeseSelected = false;
  bool _isBrazilianSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            /*   YOU CAN CLICK IN WHOLE ROW  */
            CheckboxListTile(
              title: Text("Brazilian food"),
                subtitle: Text("The best one!"),
                activeColor: Colors.red,
                selected: true, // The text also become colored
                secondary: Icon(Icons.add_box),
                value: _isBrazilianSelected,
                onChanged: (bool val) {
                  setState(() {
                    _isBrazilianSelected = val;
                  });
                }
            ),
            CheckboxListTile(
                title: Text("Japonese food"),
                subtitle: Text("Exotic!"),
                activeColor: Colors.red,
                selected: true, // The text also become colored
                secondary: Icon(Icons.add_box),
                value: _isJaponeseSelected,
                onChanged: (bool val) {
                  setState(() {
                    _isJaponeseSelected = val;
                  });
                }
            ),

            /*   YOU HAVE TO CLICK INSIDE OF THE CHECKBOX  */
//            Text("Brazilian food"),
//            Checkbox(
//              value: _isSelected, //Initial state (true == selected)
//              onChanged: (bool val) {
//                setState(() {
//                  _isSelected = val;
//                });
//                print("Checkbox " + val.toString());
//              },
//            )
            RaisedButton(
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: (){
                print("Brazilian selected ? -> " + _isBrazilianSelected.toString());
                print("Japonese selected ? -> " + _isJaponeseSelected.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
