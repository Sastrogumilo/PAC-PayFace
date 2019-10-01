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
  PayOutBloc payOutBloc;
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    payOutBloc = BlocProvider.of<PayOutBloc>(context);
    
    return BlocBuilder<PayOutBloc, PayOutState>(
      bloc: payOutBloc,
      builder: (context, state){


    final tambah_button = FloatingActionButton.extended(
      onPressed: () {},
      label: Text('Cairkan Uang'),
      icon: Icon(Icons.attach_money),
      backgroundColor: Colors.orange,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: Column(),
      floatingActionButton: tambah_button,
    );
  });}
}