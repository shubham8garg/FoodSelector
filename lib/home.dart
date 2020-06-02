import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> dinners = new List<String>();
  SharedPreferences sharedPreferences;
  TextEditingController nameController = TextEditingController();

  @override
  void initState(){ 
    loadSharedPreferencesAndData();
    super.initState();
  }

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
      body: dinners.isEmpty ? emptyList() : buildListItems(),
    );
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<String> dinnerlist = sharedPreferences.getStringList('dinners') ?? [];
    dinners = dinnerlist;
    if(dinnerlist != null){
      setState((){
        dinners = dinnerlist;
      });
    }
  }

  void addToList(){
    if (nameController.text.isNotEmpty) {
      dinners.add(nameController.text);
      sharedPreferences.setStringList('dinners', dinners);
      setState(() {
        dinners.add(nameController.text);
        loadData();
      });
    }
  }
  void saveListAfterRemoving(){
    sharedPreferences.setStringList('dinners', dinners);
    setState(() {
      loadData();
    });
  }

  Widget emptyList(){
    return Column(
            children: [
              Expanded(
                child:  Center(child: Text('No items'))
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
                    ],
                  ),
                  ),
                )
            ]
    );
  }

  Widget buildListItems(){
    return Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: dinners.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(), 
                  onDismissed: (direction) {
                    setState(() {
                      dinners.removeAt(index);
                    });
                    saveListAfterRemoving();
                  },
                  child: ListTile(
                    title: Text(dinners[index]),
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
                            content: Text("Random Dinner is: "+ dinners[random.nextInt(dinners.length)]),
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
      );
  }
}