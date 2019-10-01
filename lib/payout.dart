import 'package:flutter/material.dart';

class PayoutPage extends StatefulWidget
{
  static String tag = 'payout-page';
  @override
  _PayoutPage createState() => _PayoutPage();
}

class _PayoutPage extends State<PayoutPage> {
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
  }
}