import 'package:flutter/material.dart';

import 'DataBase.dart';

class UpdateData extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String location;

  const UpdateData({
    super.key,
    required this.id,
    required this.name,
    required this.age,
    required this.location,
  });

  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    ageController.text = widget.age.toString();
    locationController.text = widget.location;
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Data'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xffE6913C).withOpacity(0.9),
            const Color(0xff26A7E6).withOpacity(0.9),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: ageController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.cake_outlined,
                    color: Colors.white,
                  ),
                  labelText: 'Age',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  )),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: locationController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                  labelText: 'Location',
                  labelStyle: const TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  )),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> updatedData = {
                  'Name': nameController.text,
                  'Age': int.parse(ageController.text),
                  'Location': locationController.text,
                };
                await DataBase().updateUser(widget.id, updatedData);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent),
              child: const Text(
                'Update Data',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
