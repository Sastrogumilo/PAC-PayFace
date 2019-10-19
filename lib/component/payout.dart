import 'package:PayFace/repository/rekening_repo.dart';
import 'package:flutter/material.dart';
import 'package:PayFace/bloc/payout/payOut_bloc.dart';
import 'package:PayFace/bloc/payout/payOut_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




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

  void _showDialog()
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
  PayOutBloc payOutBloc;

  @override
  void initState() {
    super.initState();
    rekUserQuery();
    
  }
  @override
  Widget build(BuildContext context) {
    payOutBloc = BlocProvider.of<PayOutBloc>(context);
    return BlocBuilder<PayOutBloc, PayOutState>(
      bloc: payOutBloc,
      builder: (context, state){
        final tambahButton = FloatingActionButton.extended(
          onPressed: () => _showDialog(),
          label: Text('Cairkan Uang'),
          icon: Icon(Icons.attach_money),
          backgroundColor: Colors.orange,
        );
        return Scaffold(
          appBar: AppBar(
            title: Text('Pay Out'),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Column(
              children: <Widget>[
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                      size: 52,  
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text('Transaksi : 123123asd12'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text('Jumlah : Rp. 50,000',textAlign: TextAlign.start,),
                        )
                      ],
                    ),
                  ],
                )             
              ],
            ),
          ),
          floatingActionButton: tambahButton,
        );
      }
    );
  }
}