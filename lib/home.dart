import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> names = [
    "Aaloo Tamatar",
    "Maggi"
  ];

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Food Selector',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w900)
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(), 
                  onDismissed: (direction) {
                    setState(() {
                      names.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(names[index]),
                  )
                  );
              }
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Add New Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                            isDense: true,
                          )
                        )
                      ),
                      RaisedButton(
                        child: Text("Add"),
                        onPressed: () {
                          addToList();
                          setState(() {
                            nameController.clear();
                          });
                        }
                        )
                    ]
                  ),
                  Builder(
                    builder: (context) => RaisedButton(
                      child: Text("Get Random Name"),
                      onPressed: () {
                        var random = Random();
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Random Dinner is: "+ names[random.nextInt(names.length)]),
                            )
                        );
                      },
                    ),
                    )
                ],
              ),
              ),
            )
        ]
      ),
    );
  }
  void addToList() {
    if (nameController.text.isNotEmpty) {
      setState(() {
        names.add(nameController.text);
      });
    }
  }
}