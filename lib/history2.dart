

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
import 'dart:async';

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
  @override
  void iniState() {
    fetchKirim();
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
    final kirim_pages = Container(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Table(
            border: TableBorder.symmetric(
              inside: BorderSide(
                color: Colors.blue.shade200,
                style: BorderStyle.solid,
                width: 0.5),
            ),
            children: [
              TableRow(children: [
                FlatButton(
                  child: Text('Kirim'),
                  onPressed: () async {
                    String hasil = await isiTableKirim(context);
                  },
                ),
                FlatButton(
                  child: Text("Terima"),
                  onPressed: () {},
                ),
              ])
            ],
          )
        ),
      ),
    );

    final _ktabPages = <Widget>[
      kirim_pages,
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
  }
}
  
class IsiItemKirim {
    final String no;
    final String tanggal;
    final String nilai;
    IsiItemKirim(this.no, this.tanggal, this.nilai);
}
                    