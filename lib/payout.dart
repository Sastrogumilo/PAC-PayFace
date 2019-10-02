import 'package:flutter/material.dart';

class PayoutPage extends StatefulWidget
{
  static String tag = 'payout-page';
  @override
  _PayoutPage createState() => _PayoutPage();
}

class _PayoutPage extends State<PayoutPage> {
  _dismissDialog() {
      Navigator.pop(context);
  }

  void _show_dialog()
  {
    showDialog(
      context: context,
      builder: (context)
      {
        return AlertDialog(
          title: Text('Masukan jumlah uang yang akan dicairkan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    prefixText: '\Rp ',
                    suffixText: 'IDR',
                    labelText: 'Jumlah Uang',
                    suffixStyle: TextStyle(color: Colors.green),
                    fillColor: Colors.white30,
                    icon:Icon(Icons.attach_money),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                  //onSaved: (String value) => this._jumlah = value,
                ),
              ),
            ],
          ),
          actions: <Widget>[
              FlatButton(
                  onPressed: () {
                   _dismissDialog();
                  },
                  child: Text('Close', style: TextStyle(color: Colors.red),)),
              FlatButton(
                onPressed: () {
                  //print('HelloWorld!');
                  _dismissDialog();
                },
                child: Text('Cairkan'),
              )
            ],
        );
      }
    );
  }
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final tambah_button = FloatingActionButton.extended(
      onPressed: () => _show_dialog(),
      label: Text('Cairkan Uang'),
      icon: Icon(Icons.attach_money),
      backgroundColor: Colors.orange,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Out'),
      ),
      body: Column(
        children: <Widget>[
          
        ],
      ),
      floatingActionButton: tambah_button,
    );
  }
}