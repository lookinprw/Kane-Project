import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book and User Management',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewBookPage()),
                );
              },
              child: Text('Add New Book'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNewUserPage()),
                );
              },
              child: Text('Add New User'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewBookPage extends StatefulWidget {
  @override
  _AddNewBookPageState createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends State<AddNewBookPage> {
  int quantity = 0;
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new book'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: getImage,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.brown[200],
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 40),
                              Text(
                                'upload book cover',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Title')),
            TextField(decoration: InputDecoration(labelText: 'Author')),
            TextField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(decoration: InputDecoration(labelText: 'ISBN (option)')),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    items: ['Fiction', 'Non-fiction', 'Science', 'History']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('qty'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 0) quantity--;
                              });
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement book addition logic
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewUserPage extends StatefulWidget {
  @override
  _AddNewUserPageState createState() => _AddNewUserPageState();
}

class _AddNewUserPageState extends State<AddNewUserPage> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new user'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: getImage,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.brown[200],
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Colors.white, size: 40),
                              Text(
                                'upload profile picture',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'User real-name')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
              maxLines: 3,
            ),
            TextField(decoration: InputDecoration(labelText: 'Age')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement user addition logic
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
