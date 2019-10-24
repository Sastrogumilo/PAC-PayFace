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
      builder: (context){
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
                _createPayOut();
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
    //rekUserQuery();
    
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

        //List Isi Item
        final list_item_baris = Container(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "PO-3331-0000-111-222",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Belum Disetujui",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 8,),
                  Text(
                    "23-10-2019",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              Text(
                  "Jumlah: 300.000",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
            ],
          ),
        );
        
        final list_item = Container(
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(8, 2, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('asset/rupiah_b.png'),
                ),
              ),
              SizedBox(width: 8,),
              Flexible(
                flex: 8,
                child:  list_item_baris,
              ),
            ],
          ),
        );

        //HALAMAN MENU
        return Scaffold(
          appBar: AppBar(
            title: Text('Pay Out'),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
            child: Column(
              children: <Widget>[
                list_item
              ],
            ),
          ),
          floatingActionButton: tambahButton,
        );
      }
    );
  }

  void _createPayOut(){

  }
}