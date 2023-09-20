import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

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

  String food = 'Press';

  // ignore: non_constant_identifier_names
  void ChangeFood() {
    getList();
    Random random = Random();
    // print(daList);
    if (daList.isEmpty) {
      setState(() {
        food = 'Add Food Items\nbefore attempting to select food';
      });
    } else {
      index = random.nextInt(daList.length);
      setState(() {
        food = daList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        Container(
          height: 100,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              food,
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.list_alt_rounded,
                    size: 35,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/list');
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
                      Icons.replay_outlined,
                    ),
                    color: Colors.black,
                    onPressed: ChangeFood,
                  ),
                ],
              ),
              Container(
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
            ],
          ),
        ),
      ],
    );
  }
}
