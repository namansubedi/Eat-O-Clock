import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Color.fromARGB(0, 89, 89, 89),
        backgroundColor: Color.fromARGB(0, 89, 89, 89),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Image.asset('assets/depAsset 5wavy.png'),
            ),
            ShowList(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  'designed and developed by\nmoon 2022',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}

class ShowList extends StatefulWidget {
  const ShowList({Key? key}) : super(key: key);

  @override
  State<ShowList> createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Container(
              height: 400,
              width: 500,
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: MainList(),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Center(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 40,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  List<String> daList = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<List> getList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('foods');
    if (items == null) {
      // print('nothing on list');
      return daList;
    } else {
      daList = items;
      return daList;
    }
  }

  void deleteFood(int index1) async {
    final prefs = await SharedPreferences.getInstance();
    // print(daList);
    daList.removeAt(index1);
    // print(daList);
    // print('im at deletefood $index');
    await prefs.setStringList('foods', daList);
    Navigator.pop(context);
    Navigator.pushNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: FutureBuilder<List>(
        future: getList(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: daList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 50,
                // color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${daList[index]}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    IconButton(
                        onPressed: () {
                          deleteFood(index);
                        },
                        icon: Icon(Icons.delete)),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
