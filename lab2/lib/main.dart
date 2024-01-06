import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Clothes {
  String name;

  Clothes(this.name);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clothes List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Clothes> clothesList = [];
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _editTextController = TextEditingController();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: clothesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: selectedIndex == index ? Colors.grey : null,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Text(
                            clothesList[index].name,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Add Clothes',
                        style: TextStyle(color: Colors.blue),
                      ),
                      content: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          labelText: 'Clothes Name',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              clothesList.add(Clothes(_textEditingController.text));
                              _textEditingController.clear();
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  if (selectedIndex != -1) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          'Edit Clothes',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: TextField(
                          controller: _editTextController,
                          decoration: InputDecoration(
                            labelText: 'Clothes Name',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                clothesList[selectedIndex].name = _editTextController.text;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an item to edit.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Edit',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  if (selectedIndex != -1) {
                    setState(() {
                      clothesList.removeAt(selectedIndex);
                      selectedIndex = -1;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select an item to delete.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
