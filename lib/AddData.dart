import 'package:firebase_crud/DataBase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool isLoading = false;

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
        title: const Text('Add Data'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            const Color(0xffE6913C).withOpacity(0.9),
            const Color(0xff26A7E6).withOpacity(0.9),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            const SizedBox(height: 20),
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
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      String id = randomAlphaNumeric(10);
                      Map<String, dynamic> userdataInfo = {
                        'Name': nameController.text,
                        'Age': int.parse(ageController.text),
                        'Location': locationController.text,
                      };

                      try {
                        await DataBase().userDetails(userdataInfo, id);
                        Fluttertoast.showToast(
                          msg: "Data is added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.green,
                          textColor: Colors.white70,
                          fontSize: 15,
                        );
                      } catch (e) {
                        Fluttertoast.showToast(
                          msg: "Error: $e",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white70,
                          fontSize: 15,
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent),
                    child: const Text(
                      'Add Data',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
