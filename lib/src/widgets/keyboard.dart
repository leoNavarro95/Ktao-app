import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

/// Implementacion de un teclado numérico customizado
class CustumNumericKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;

  CustumNumericKeyboard({Key key, this.notifier}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(300);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: preferredSize.height,
        width: 300,
        margin: EdgeInsets.all(5),
        child: Table(
          
      children: [
        TableRow(
          children: [
            _digitsButtom(1),
            _digitsButtom(2),
            _digitsButtom(3),
          ],
        ),
        TableRow(
          children: [
            _digitsButtom(4),
            _digitsButtom(5),
            _digitsButtom(6),
          ],
        ),
        TableRow(
          children: [
            _digitsButtom(7),
            _digitsButtom(8),
            _digitsButtom(9),
          ],
        ),
        TableRow(
          children: [Container(), _digitsButtom(0), Container()],
        )
      ],
    ));
  }

  Widget _digitsButtom(int digit) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          color: Colors.blue,
          child: Text(digit.toString(), style: TextStyle(color: Colors.white, fontSize: 25),),
          onPressed: (){

          }
          ),
      ),
    );
    
  }
}
