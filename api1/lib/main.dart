import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String responselore;
  List listlore;
  Map maplore;
  List listofdata;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    if (response.statusCode == 200) {
      setState(() {
        maplore = json.decode(response.body);
        listofdata = maplore['data'];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("contact"),
        ),
        body: maplore == null
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      maplore[''].toString(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Image.network(listofdata[index]['avatar']),
                              Text(
                                listofdata[index]['email'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                listofdata[index]['first_name'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                listofdata[index]['last_name'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: listofdata == null ? 0 : listofdata.length,
                    )
                  ],
                ),
              ));
  }
}
