

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:PayFace/bloc/history/history_bloc.dart';
import 'package:PayFace/bloc/history/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//Contoh Data
Future<String> loadAsset(String path) async {
  return await rootBundle.loadString(path);
}

class HistoryPage2 extends StatefulWidget {
  static String tag = 'history-page';
  @override 
  _HistoryPageState2 createState() => _HistoryPageState2();
}

//REF = https://stackoverflow.com/questions/51036758/flutter-the-method-map-was-called-on-null
class _HistoryPageState2 extends State<HistoryPage2> {
  HistoryBloc historyBloc;
  List<IsiItemKirim> _kirimList;
  fetchKirim() async {
    String data = await loadAsset('asset/contohData.txt');
    print(data);
    var jsonData = json.decode(data);
    List<IsiItemKirim> kirimList = [];
    for (var u in jsonData) {
      IsiItemKirim kirim = IsiItemKirim(u["No"], u["Tanggal"], u["Nilai"]);
      kirimList.add(kirim);
      print(kirim.no+" "+kirim.tanggal+" "+kirim.nilai);
    }
    //print(kirimList);
    this.setState((){
      _kirimList = kirimList;
    });
  }

  
  //GET DATA
  isiTableKirim(context) async {
    SafeArea(
      child: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text("No")),
            DataColumn(label: Text("Tanggal")),
            DataColumn(label: Text("Nilai")),
          ],
          sortColumnIndex: 1,
          rows: _kirimList?.map(((isi) => DataRow(
            cells: <DataCell> [
              DataCell(Text(isi.no)),
              DataCell(Text(isi.tanggal)),
              DataCell(Text(isi.nilai))
            ]
          ))
          )?.toList() ??[],
        )
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    historyBloc= BlocProvider.of<HistoryBloc>(context);
    
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: historyBloc,
      builder: (context, state){
    final kirim_pages = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('asset/images/topup.png'),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "TT-12323-00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "50.000",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    
    final _ktabPages = <Widget>[
      Column(
        children: <Widget>[
          kirim_pages,
          kirim_pages,
        ],
      ),
      Center(child: Text('Top Up',style: TextStyle(color: Colors.black87))),
      Center(child: Text('Pay Out',style: TextStyle(color: Colors.black87)))
    ];
    final _kTabs = <Tab>[
      Tab(text: 'Transfer',),
      Tab(text: 'Top Up',),
      Tab(text: 'Pay Out',)
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Transaksi'),
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _ktabPages,
        )
      ),
    );
  });}
}
  
class IsiItemKirim {
    final String no;
    final String tanggal;
    final String nilai;
    IsiItemKirim(this.no, this.tanggal, this.nilai);
}
                    