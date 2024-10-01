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
      debugShowCheckedModeBanner: false,
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
        centerTitle: true,
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
        title: Text('Add New Book'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: getImage,
                child: SizedBox(
                  width: 150,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.white, size: 24),
                                Text(
                                  'Upload Cover',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_image!, fit: BoxFit.cover),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Title Field
            Text(
              'Title',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Author Field
            Text(
              'Author',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Description Field
            Text(
              'Description',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),

            // ISBN Field
            Text(
              'ISBN (option)',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Category Field
            Text(
              'Category',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ['Fiction', 'Non-fiction', 'Science', 'History']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
            SizedBox(height: 16),

            // Qty Field
            Text(
              'Qty',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
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
            SizedBox(height: 16),

            // Confirm Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement book addition logic
                },
                child: Text(
                  'Confirm',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[200], // Set button color
                  padding: EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32), // Adjusted padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners // Rounded corners
                  ),
                ),
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
  final TextEditingController _realNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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
        title: Text('Add New User'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Upload Field
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: getImage,
                      child: Container(
                        width: 150, // Adjust the width
                        height: 200, // Adjust the height
                        decoration: BoxDecoration(
                          color: Colors.brown[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _image == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add,
                                        color: Colors.white, size: 24),
                                    Text(
                                      'Upload',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Real Name Field
              Text(
                'User Real Name',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _realNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Email Field
              Text(
                'Email',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Address Field
              Text(
                'Address',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),

              // Age Field
              Text(
                'Age',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Confirm Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement user addition logic
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[200], // Set button color
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32), // Adjusted padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          12), // Rounded corners // Rounded corners
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
