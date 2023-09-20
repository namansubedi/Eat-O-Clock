// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Color.fromARGB(0, 89, 89, 89),
        backgroundColor: Color.fromARGB(0, 89, 89, 89),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Image.asset('assets/depAsset 5wavy.png'),
          ),
          AddStack(),
          Expanded(
            flex: 100,
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
      extendBodyBehindAppBar: true,
    );
  }
}

class AddStack extends StatefulWidget {
  const AddStack({Key? key}) : super(key: key);

  @override
  State<AddStack> createState() => _AddStackState();
}

class _AddStackState extends State<AddStack> {
  List<String> daList = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('foods');
    if (items == null) {
      // print('nothing on list');
    } else {
      daList = items;
      // print(items);
    }
  }

  Future<void> checkSP() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('foods');
    // print(items);
  }

  void addToList(String newFood) async {
    daList.add(newFood);
    // print('im at addtolist $newFood');
    saveToList();
    checkSP();
    await Future.delayed(Duration(seconds: 1));
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  Future<void> saveToList() async {
    final prefs = await SharedPreferences.getInstance();
    // print('im at savetolist $daList');
    await prefs.setStringList('foods', daList);
  }

  List<String>? foodList = [];
  final FoodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Container(
          // color: Color.fromARGB(255, 201, 198, 189),
          height: 70,
          width: MediaQuery.of(context).size.width / 1.2,
          child: TextField(
            controller: FoodController,
            maxLength: 20,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: Colors.white), //<-- SEE HERE
                borderRadius: BorderRadius.circular(15.0),
              ),
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              focusColor: Colors.white,
              border: OutlineInputBorder(),
              labelText: 'type in new food',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 50,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 35,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    iconSize: 70,
                    icon: Icon(
                      Icons.add,
                    ),
                    color: Colors.black,
                    onPressed: () => addToList(FoodController.text.trim()),
                  ),
                ],
              ),
              Opacity(
                opacity: 0,
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 35,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/add');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
